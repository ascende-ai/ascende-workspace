# Implementation Plan: Eigent Engine in Ascende Agent

**Version:** 1.1  
**Date:** 2025-02-11  
**Related:** [PRD_EIGENT_ENGINE.md](PRD_EIGENT_ENGINE.md)  
**Changelog (1.1):** Added Phase 1.4 (client-delegated tools), Phase 4.3 (ToolExecutor), protocol details, tool-result API

---

## Overview

This plan covers:

1. **Backend:** Fork Eigent's Python backend into ascende-workspace and prepare for Ascende deployment
2. **Client:** Replace Cline in ascende-agent with an Eigent protocol client

Hard cutover: Eigent only; no Cline fallback.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  ascende-lde (VS Code fork)                                      │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  ascende-agent extension                                     ││
│  │  ┌──────────────┐  ┌──────────────────┐  ┌───────────────┐ ││
│  │  │ ClineProvider│──│ EigentOrchestrator│──│ EigentSSEClient│ ││
│  │  └──────────────┘  └──────────────────┘  └───────┬───────┘ ││
│  │         │                    │                     │         ││
│  │         ▼                    ▼                     │         ││
│  │  ┌──────────────┐     ┌─────────────────┐          │         ││
│  │  │ Webview UI   │◄────│ postMessage     │          │         ││
│  │  │ (Chat+Tasks) │     │ (SSE events)    │          │         ││
│  │  └──────────────┘     └─────────────────┘          │         ││
│  └─────────────────────────────────────────────────────┼─────────┘│
└────────────────────────────────────────────────────────┼─────────┘
                                                         │
                                         POST /chat      │ SSE
                                         human-reply     │ stream
                                         stop, etc.      │
                                                         ▼
┌─────────────────────────────────────────────────────────────────┐
│  Ascende Hosted Backend (Eigent fork)                           │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  FastAPI + CAMEL Workforce                                   ││
│  │  /chat (POST) → SSE stream                                   ││
│  │  /chat/{id}/human-reply, /chat/{id}/tool-result              ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘

Client-executed tools (VS Code integration):
  Backend emits execute_* events → Extension runs via VS Code APIs → POST tool-result → Backend continues
```

---

## Phase 1: Backend Fork

**Goal:** Eigent backend lives in ascende-workspace; runs locally for dev; ready for hosted deployment.

### 1.1 Add Backend Package

- **Location:** `ascende-workspace/eigent-backend/` (or `ascende-workspace/backend/` if preferred)
- **Action:** Copy from [eigent-ai/eigent](https://github.com/eigent-ai/eigent) `backend/` directory
- **Preserve:** Full Eigent backend structure—`app/`, `main.py`, `pyproject.toml`, `uv.lock`
- **License:** Ensure Apache 2.0 attribution

### 1.2 Adapt for Ascende

- **Auth:** Replace or wrap Eigent auth with Ascende token validation (middleware)
- **Config:** Environment variables for `ASCENDE_API_URL`, model config, etc.
- **Paths:** `file_save_path` defaults; document expected structure from client
- **CORS:** Allow extension origin (or proxy) for `/chat` SSE

### 1.3 Local Dev Setup

- **Script:** `./scripts/start-backend.sh` (or equivalent) to run `uv run uvicorn main:app`
- **Port:** Configurable (e.g. 8000); client uses `http://localhost:{port}` in dev
- **Docs:** Add to `docs/START_DEV.md` or new `docs/BACKEND_DEV.md`

### 1.4 Client-Delegated Tool Execution (Backend Changes)

**Problem:** Hosted backend cannot access user's filesystem or terminal. Workers must delegate file and terminal operations to the client.

**Approach:** Introduce "client-delegated" toolkits that emit execution requests instead of executing locally.

- **New toolkit wrappers or modes:** For Developer Agent (and others that need workspace access): when a tool would run (e.g. `write_file`, `run_terminal`), instead of executing on the server, emit an SSE event to the client
- **Event format:** `execute_file_write`, `execute_terminal`, `execute_read_file`, `execute_search_replace`, `execute_list_files`, etc.
- **Client executes** via VS Code APIs and POSTs result to `POST /chat/{id}/tool-result`
- **Backend waits** for tool result (or uses async queue) before continuing the worker's step

**Required backend changes:**

1. **New endpoint:** `POST /chat/{project_id}/tool-result`
   - Body: `{ "request_id": "...", "tool_name": "write_file", "result": { "success": true, "output": "..." } }`
   - Backend matches `request_id` to pending tool request, injects result into worker's execution

2. **Toolkit adaptation:** Create `ClientDelegatedTerminalToolkit`, `ClientDelegatedFileWriteToolkit`, etc. that:
   - Queue a tool execution request with unique `request_id`
   - Emit `execute_*` SSE event with `request_id`, params (path, content, command, etc.)
   - Await result via internal queue (blocking worker until client responds)
   - Return result to worker as if tool executed locally

3. **Worker config:** Developer Agent (and Document Agent if it writes to workspace) use client-delegated toolkits when `workspace_mode=client` (or similar) is set in chat params

**Eigent already emits `write_file` and `terminal`** for display. Extend protocol: these events can include `request_id` and `await_result: true`; client executes, then POSTs tool-result with that `request_id`. Backend must be modified to wait for and consume tool results.

### 1.5 Deployment Prep (for later)

- **Dockerfile:** Optional; for containerized deployment
- **Health check:** `/health` endpoint (Eigent has this)
- **Secrets:** Document required env vars for production

---

## Protocol: Client-Executed Tools

| Step | Backend | Client |
|------|---------|--------|
| 1 | Worker calls tool (e.g. write_file) | — |
| 2 | Client-delegated toolkit emits SSE: `{ "step": "execute_file_write", "data": { "request_id": "uuid", "path": "src/foo.ts", "content": "..." } }` | — |
| 3 | — | Extension receives event |
| 4 | — | Extension calls `vscode.workspace.fs.writeFile(uri, content)` |
| 5 | — | Extension POSTs to `/chat/{id}/tool-result`: `{ "request_id": "uuid", "result": { "success": true } }` |
| 6 | Backend receives result, injects into worker, continues | — |

**Tool event schema (emit from backend):**

```json
{ "step": "execute_file_write", "data": { "request_id": "...", "path": "relative/to/workspace", "content": "..." } }
{ "step": "execute_read_file", "data": { "request_id": "...", "path": "..." } }
{ "step": "execute_search_replace", "data": { "request_id": "...", "path": "...", "old_string": "...", "new_string": "..." } }
{ "step": "execute_list_files", "data": { "request_id": "...", "pattern": "*.ts" } }
{ "step": "execute_terminal", "data": { "request_id": "...", "command": "npm install", "cwd": "..." } }
```

**Tool result schema (POST from client):**

```json
{ "request_id": "...", "result": { "success": true, "content": "..." } }
{ "request_id": "...", "result": { "success": false, "error": "..." } }
```

---

## Phase 2: Client — Configuration and Types

**Goal:** Extension can be configured to talk to Ascende backend.

### 2.1 Ascende Backend Config

- **File:** `ascende-agent/src/shared/ascendeBackend.ts`
- **Fields:** `ascendeBackendUrl`, `ascendeApiKey` (or token)
- **Storage:** `context.secrets` for key; settings for URL

### 2.2 Eigent Types

- **File:** `ascende-agent/src/services/eigent/types.ts`
- **Contents:** `ChatParams`, `SSEEvent`, `AgentStep` enum (confirmed, to_sub_tasks, create_agent, assign_task, ask, task_state, end, error, timeout, **execute_file_write, execute_read_file, execute_search_replace, execute_list_files, execute_terminal**), `ToolResult`
- **Align with:** Eigent `app/service/task.py` `Action` enum

---

## Phase 3: Client — EigentSSEClient

**Goal:** Client can start chat, consume SSE, and call task/human-reply APIs.

### 3.1 Create EigentSSEClient

- **File:** `ascende-agent/src/services/eigent/EigentSSEClient.ts`
- **Methods:**
  - `startChat(params: ChatParams): AsyncIterable<SSEEvent>`
  - `stopChat(projectId: string): Promise<void>`
  - `humanReply(projectId: string, agent: string, reply: string): Promise<void>`
  - **`toolResult(projectId: string, requestId: string, result: ToolResult): Promise<void>`** — POST tool execution result
  - `addTask(projectId: string, content: string, ...): Promise<void>`
  - `removeTask(projectId: string, taskId: string): Promise<void>`
  - `skipTask(projectId: string): Promise<void>`
  - `improve(projectId: string, question: string, taskId?: string): Promise<void>`
- **Use:** `fetch` + `ReadableStream` or `@microsoft/fetch-event-source`
- **Auth:** `Authorization: Bearer ${token}`

---

## Phase 4: Client — EigentOrchestrator

**Goal:** Replace Cline loop with orchestrator that consumes SSE and drives webview.

### 4.1 Create EigentOrchestrator

- **File:** `ascende-agent/src/core/EigentOrchestrator.ts`
- **Responsibilities:**
  - `startTask(question: string, images?: string[]): Promise<void>`
  - Consume SSE; on each event, dispatch handler and `postMessage` to webview
  - On `ask`: wait for webview reply, call `humanReply`
  - On `end`: cleanup, emit `taskCompleted`
- **Events:** `taskStarted`, `taskCompleted`, `taskAborted`

### 4.2 Event Handlers

Map each `step` to handler:
- `confirmed`, `to_sub_tasks` → task list
- `create_agent`, `assign_task`, `activate_agent`, `deactivate_agent` → worker state
- `ask` → human prompt, wait for reply
- `task_state`, `new_task_state` → task status
- `end`, `error`, `timeout` → cleanup / error UI
- **`execute_file_write`, `execute_read_file`, `execute_search_replace`, `execute_list_files`, `execute_terminal`** → delegate to ToolExecutor (see 4.3)

### 4.3 Tool Executor (VS Code Integration)

**File:** `ascende-agent/src/core/eigent/ToolExecutor.ts`

**Responsibilities:** Execute client-delegated tool requests using VS Code APIs; POST results back to backend.

- **execute_file_write:** Resolve path relative to workspace, call `vscode.workspace.fs.writeFile`
- **execute_read_file:** `vscode.workspace.fs.readFile`, return content (utf-8)
- **execute_search_replace:** Read file, apply replace, write back (or use `TextDocument`/`TextEdit` if available)
- **execute_list_files:** `vscode.workspace.findFiles` with pattern
- **execute_terminal:** Reuse Cline's `Terminal` / `RooTerminalProcess` from `ascende-agent/src/integrations/terminal/`; run command, capture output, POST result

**Flow:**
1. EigentOrchestrator receives `execute_*` event
2. Delegates to ToolExecutor with workspace path from `vscode.workspace`
3. ToolExecutor runs operation, gets result
4. EigentOrchestrator (or EigentSSEClient) POSTs `tool-result` to backend

**Reuse:** Cline's tools in `ascende-agent/src/core/tools/` (readFileTool, writeToFileTool, searchAndReplaceTool, executeCommandTool, listFilesTool, searchFilesTool) — adapt their logic for the ToolExecutor; they already use VS Code APIs.

---

## Phase 5: Client — ClineProvider Integration

**Goal:** ClineProvider uses EigentOrchestrator instead of Cline.

### 5.1 Replace Cline with EigentOrchestrator

- **File:** `ascende-agent/src/core/webview/ClineProvider.ts`
- **Changes:**
  - Instantiate `EigentOrchestrator` instead of `Cline`
  - Wire `startTask`, `abortTask`, etc. to orchestrator
  - Remove Cline-specific logic (initiateTaskLoop, etc.)

### 5.2 Webview Message Handler

- **File:** `ascende-agent/src/core/webview/webviewMessageHandler.ts`
- **Add:** `humanReplySubmitted`, `addTask`, `removeTask`, `skipTask` → route to EigentOrchestrator

---

## Phase 6: Client — Webview UI

**Goal:** Webview renders workforce state and human-in-the-loop.

### 6.1 Extended Message Types

- **File:** `ascende-agent/src/shared/ExtensionMessage.ts`
- **New:** `workforce`, `taskList`, `workerAssign`, `humanAsk` (or equivalent) message types

### 6.2 Task List Component

- **File:** `ascende-agent/webview-ui/src/components/chat/TaskList.tsx`
- **Renders:** Subtasks, status (empty/running/done/failed), optional expand

### 6.3 Human-in-the-Loop UI

- Reuse existing ask/response pattern where possible
- On `ask` event: show prompt, input field; on submit send `humanReplySubmitted`

### 6.4 Chat Integration

- Integrate TaskList into ChatView (above or beside messages)
- Render workforce events as message-like blocks (e.g. "Agent X working on task Y")

---

## Phase 7: Auth and Settings

### 7.1 Ascende Auth

- Adapt existing PearAI login flow for Ascende
- Store token in `context.secrets`

### 7.2 Settings UI

- **File:** `ascende-agent/webview-ui/src/components/settings/SettingsView.tsx`
- **Add:** Ascende Backend section—URL, API key (masked), Test Connection

---

## Phase 8: Cleanup

**Goal:** Remove all Cline code and unused providers.

### 8.1 Remove Cline

- Delete or strip `Cline.ts` usage
- Remove `initiateTaskLoop`, `recursivelyMakeClineRequests`, tool execution loop

### 8.2 Remove Unused API Providers

- Remove LLM providers used only by Cline (Anthropic, OpenAI, etc.) unless needed for other features

### 8.3 Dependencies

- Add: `@microsoft/fetch-event-source` (if used)
- Remove: Unused Cline deps

---

## Implementation Order

| Phase | Summary | Depends On |
|-------|---------|------------|
| 1 | Backend fork + client-delegated tool execution | — |
| 2 | Client config and types | — |
| 3 | EigentSSEClient (incl. toolResult) | 2 |
| 4 | EigentOrchestrator + ToolExecutor (VS Code integration) | 3 |
| 5 | ClineProvider integration | 4 |
| 6 | Webview UI (TaskList, human reply) | 5 |
| 7 | Auth and settings | 2, 5 |
| 8 | Cleanup (remove Cline) | 6, 7 |

**Recommended sequence:** 1 → 2 → 3 → 4 (can run backend + client in parallel after 1); then 5 → 6 → 7 → 8. Phase 1.4 (client-delegated tools) and Phase 4.3 (ToolExecutor) are required for VS Code integration—files and terminal must work in the user's workspace.

---

## Key Files

### Backend (new)

| Path | Purpose |
|------|---------|
| `eigent-backend/` (or `backend/`) | Eigent fork root |
| `eigent-backend/app/` | FastAPI app, workforce, controllers |

### Client (create/modify)

| Action | Path |
|--------|------|
| Create | `ascende-agent/src/shared/ascendeBackend.ts` |
| Create | `ascende-agent/src/services/eigent/types.ts` |
| Create | `ascende-agent/src/services/eigent/EigentSSEClient.ts` |
| Create | `ascende-agent/src/core/EigentOrchestrator.ts` |
| **Create** | **`ascende-agent/src/core/eigent/ToolExecutor.ts`** — executes client-delegated tools via VS Code APIs |
| Modify | `ascende-agent/src/core/webview/ClineProvider.ts` |
| Modify | `ascende-agent/src/core/webview/webviewMessageHandler.ts` |
| Create | `ascende-agent/webview-ui/src/components/chat/TaskList.tsx` |
| Modify | `ascende-agent/webview-ui/src/components/chat/*` |
| Modify | `ascende-agent/webview-ui/src/components/settings/SettingsView.tsx` |
| Modify | `ascende-agent/src/shared/ExtensionMessage.ts` |

### Remove

| Path | When |
|------|------|
| Cline.ts usage in ClineProvider | Phase 5 |
| `initiateTaskLoop`, `recursivelyMakeClineRequests` | Phase 8 |
| Unused LLM providers | Phase 8 |

---

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Backend API drift | Pin Eigent version; document event schema |
| Workspace path on backend | Validate before send; document expected format; paths relative to workspace root |
| Human-reply timing | Ensure reply sent promptly; backend queues |
| CORS | Backend allows extension origin or use proxy |
| Tool execution blocking | Backend must wait for tool-result; set timeout and error handling if client doesn't respond |
| Path resolution | ToolExecutor resolves relative paths against `workspace.workspaceFolders[0].uri`; handle multi-root |
