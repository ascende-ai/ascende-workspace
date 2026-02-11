#!/usr/bin/env bash
# Start Eigent backend (Ascende fork) for local development.
# Usage: ./scripts/start-backend.sh [port]
# Default port: 8000

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BACKEND_DIR="$WORKSPACE_ROOT/eigent-backend"
PORT="${1:-8000}"

cd "$BACKEND_DIR"

if ! command -v uv &> /dev/null; then
  echo "Error: uv is required. Install from https://docs.astral.sh/uv/"
  exit 1
fi

# Sync dependencies if needed
if [ ! -d ".venv" ]; then
  echo "Creating virtual environment..."
  uv sync
fi

echo "Starting Eigent backend on port $PORT..."
echo "  API: http://localhost:$PORT"
echo "  Health: http://localhost:$PORT/health"
echo ""

uv run uvicorn main:api --reload --host 0.0.0.0 --port "$PORT"
