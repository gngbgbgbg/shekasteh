#!/bin/bash
set -e

echo "Starting Ollama..."
ollama serve &
OLLAMA_PID=$!

echo "Waiting for Ollama..."
until curl -sf http://127.0.0.1:11434/api/tags >/dev/null; do
    sleep 2
done

echo "Starting Open WebUI..."

cd /app/backend

export OLLAMA_BASE_URL=http://127.0.0.1:11434
export PORT=8080
export HOST=0.0.0.0

exec python3 -m open_webui
