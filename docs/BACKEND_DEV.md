# Eigent Backend – Local Development

This guide covers running the Ascende-forked Eigent backend locally for development.

## Prerequisites

- **Python 3.11** (required by Eigent/CAMEL)
- **uv** – Python package manager. Install with:
  - `brew install uv` (macOS)
  - `curl -LsSf https://astral.sh/uv/install.sh | sh` (Linux/macOS)
  - See [https://docs.astral.sh/uv/](https://docs.astral.sh/uv/)

## Quick Start

From the workspace root:

```bash
./scripts/start-backend.sh
```

Default port: `8000`. To use a different port:

```bash
./scripts/start-backend.sh 9000
```

## Manual Start

```bash
cd eigent-backend
uv sync
uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /health` | Health check |
| `POST /chat` | Start chat session (SSE stream) |
| `POST /chat/{id}/human-reply` | Human-in-the-loop reply |
| `POST /chat/{id}/tool-result` | Client-delegated tool execution result |
| `DELETE /chat/{id}` | Stop chat |
| `POST /chat/{id}/add-task` | Add subtask |
| `DELETE /chat/{project_id}/remove-task/{task_id}` | Remove subtask |
| `POST /chat/{project_id}/skip-task` | Skip current task |

## Environment Variables

Create `~/.eigent/.env` or set:

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | API key for OpenAI-compatible models |
| `OPENAI_API_BASE_URL` | Optional model API base (default: OpenAI) |
| `ASCENDE_CORS_ORIGINS` | Comma-separated CORS origins (default: `*`) |
| `PORT` | Port for uvicorn (when not using start script) |

## Client Connection

For local development, the ascende-agent extension should connect to:

```
http://localhost:8000
```

(Or the port you configured.)

## Client-Delegated Tools

When `workspace_mode=client` (future Phase 4), file and terminal operations are delegated to the VS Code extension:

1. Backend emits `execute_file_write`, `execute_read_file`, `execute_terminal`, etc. via SSE
2. Extension executes via VS Code APIs
3. Extension POSTs result to `/chat/{id}/tool-result`
4. Backend continues execution with the result

Event schema is documented in [IMPLEMENTATION_PLAN_EIGENT_ENGINE.md](../IMPLEMENTATION_PLAN_EIGENT_ENGINE.md).
