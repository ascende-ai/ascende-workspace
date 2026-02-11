# Product Requirements Document: Eigent Engine in Ascende Agent

**Version:** 1.1  
**Date:** 2025-02-11  
**Status:** Draft  
**Changelog (1.1):** Added VS Code integration requirement (4.7) and client-executed tools pattern

---

## 1. Problem Statement

Ascende Agent currently uses a single-agent loop (Cline) that processes tasks sequentially with direct LLM calls and local tool execution. Users need a **multi-agent workforce** that:

- Decomposes complex tasks into subtasks with dependencies
- Assigns work to specialized agents (developer, browser, document, multi-modal, MCP) in parallel
- Supports human-in-the-loop when agents need clarification
- Provides visibility into task decomposition, worker assignment, and progress

The Eigent engine (CAMEL-AI workforce) provides this capability. The goal is to replace the current Cline-based agent with Eigent, running as Ascende's hosted backend.

---

## 2. Goals

| Goal | Description |
|------|-------------|
| **Replace agent engine** | Remove Cline; use Eigent workforce as the sole agent engine |
| **Hosted backend** | Fork Eigent's backend into ascende-workspace; deploy as Ascende's service |
| **Full parity** | Support all Eigent features: decomposition, all workers, human-in-the-loop, stop/pause/resume, add/remove tasks |
| **Built-in experience** | Extension ships with the app—no separate install. User installs Ascende once. |
| **VS Code-centric UI** | Reuse ascende-agent's webview look and feel; add workforce-specific components (task list, workers, human prompts) |
| **VS Code integration** | Eigent must operate on the user's workspace: files created/edited appear in the editor; terminal commands run in VS Code's terminal; equivalent to Cline's integrations |

---

## 3. User Stories

### Primary

1. **As a developer**, I want to describe a complex task and see it decomposed into subtasks, so that I understand what the system will do before execution.
2. **As a developer**, I want specialized agents (code, browser, document, etc.) to work on subtasks in parallel, so that complex work completes faster.
3. **As a developer**, I want the system to ask me for input when it's unsure, so that I can provide context or approve actions.
4. **As a developer**, I want to stop, pause, or resume task execution, and add or remove subtasks, so that I stay in control.

### Secondary

5. **As a developer**, I want to see which agent is working on which subtask and their progress, so that I can reason about what's happening.
6. **As an Ascende user**, I want to use the agent without running a local backend, so that setup is minimal.
7. **As a developer**, I want files created or edited by the agent to appear in my VS Code workspace, so that I can review and edit them directly.
8. **As a developer**, I want terminal commands run by the agent to execute in VS Code's integrated terminal, so that I can see output and interact if needed.

---

## 4. Functional Requirements

### 4.1 Task Decomposition

- User sends a natural language task to the agent
- Backend decomposes the task into subtasks with dependencies
- Client displays the decomposition (task list) before execution starts
- User can edit the task list (add, remove, reorder) before starting

### 4.2 Workforce Execution

- Backend assigns subtasks to workers based on capability and dependencies
- Supported workers: Developer, Browser, Document, Multi-Modal, MCP, Social Media
- Workers execute in parallel when dependencies allow
- Client shows which worker is handling which subtask and status (waiting, running, done, failed)

### 4.3 Human-in-the-Loop

- When a worker needs user input (e.g., approval, clarification), backend emits an `ask` event
- Client displays the prompt and input field
- User submits a reply; client sends it to backend via `human-reply` API
- Execution resumes after reply is received

### 4.4 Task Control

- **Stop:** User can stop the workforce at any time
- **Pause/Resume:** User can pause execution and resume later (take control)
- **Add task:** User can add a new subtask to the pending list
- **Remove task:** User can remove a subtask from the list
- **Skip task:** User can skip the current task (preserves context for follow-up)

### 4.5 Authentication

- User authenticates with Ascende (OAuth or API key)
- Token is stored securely; used for backend API calls
- Unauthenticated users cannot start tasks

### 4.6 Workspace Context

- Extension passes workspace path to backend
- User can optionally pass `.env` path for environment variables

### 4.7 VS Code Integration (Client-Executed Tools)

Because the backend is hosted remotely, it cannot directly access the user's filesystem or terminal. File operations and terminal execution must run in the extension (client) using VS Code APIs, so that:

- **Files** created or edited by workers appear in the user's workspace and are visible in the editor
- **Terminal** commands run in VS Code's integrated terminal; output is visible and user can interact
- **Diffs** (for proposed edits) can be shown in the editor when applicable

**Mechanism:** Client-executed tools (hybrid pattern):

1. Backend workers use toolkits that emit "execute this tool" requests instead of executing locally
2. These requests are sent to the client via the SSE stream (e.g. `execute_file_write`, `execute_terminal`, `execute_read_file`)
3. The extension receives them and performs the operation using VS Code APIs (`vscode.workspace.fs`, `Terminal`, etc.)
4. The extension sends the result back to the backend (e.g. via `POST /chat/{id}/tool-result`)
5. The backend continues the workflow with the result

**Tools to replicate from Cline:**

| Cline tool | VS Code API / integration | Eigent event |
|------------|---------------------------|--------------|
| read_file | `vscode.workspace.fs.readFile` | `execute_read_file` |
| write_to_file | `vscode.workspace.fs.writeFile` | `execute_file_write` |
| search_replace | read + write or `TextDocument` | `execute_search_replace` |
| list_files | `vscode.workspace.findFiles` | `execute_list_files` |
| execute_command | `Terminal` / `RooTerminalProcess` | `execute_terminal` |
| MCP tools | `McpHub.callTool` | Delegate to client MCP or backend |

---

## 5. Non-Functional Requirements

| Requirement | Target |
|-------------|--------|
| **Latency** | First SSE event within 5s of POST /chat |
| **Reliability** | SSE connection retries on transient failure |
| **Security** | API key/token never logged or exposed to webview |
| **Offline** | Graceful error when backend unreachable |
| **Compatibility** | Works with Ascende.ai app (ascende-lde); extension built-in |

---

## 6. Out of Scope (v1)

- Local backend mode (user running Eigent locally)
- Cline fallback or toggle between engines
- Custom worker creation beyond pre-defined workers
- Replay / replay-from-checkpoint

---

## 7. Success Criteria

1. User can start a complex task and see decomposition before execution
2. All six worker types (developer, browser, document, multi-modal, MCP, social media) can be assigned and execute tasks
3. Human-in-the-loop prompts appear and user replies are sent correctly
4. Stop, pause/resume, add/remove task, skip task all work end-to-end
5. No Cline code paths remain; agent is 100% Eigent-driven
6. **Files created or edited by the agent appear in the user's VS Code workspace**
7. **Terminal commands run by the agent execute in VS Code's integrated terminal with visible output**

---

## 8. Dependencies

- Eigent backend fork in ascende-workspace
- Ascende hosted deployment (infrastructure)
- Ascende auth (OAuth or API key issuance)
