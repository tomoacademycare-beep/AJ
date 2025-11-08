#!/usr/bin/env bash
set -e

# start.sh - ensures model exists, starts ollama, then runs gunicorn for API
APP_DIR=/app
MODEL_NAME=aj-mini

cd $APP_DIR

# If ollama is missing, print message and continue to attempt fallback
if ! command -v ollama >/dev/null 2>&1; then
  echo "Warning: ollama binary not found in container. Make sure Ollama was installed."
fi

# Create model if Modelfile exists and model not present
if command -v ollama >/dev/null 2>&1; then
  if ! ollama list | grep -q "$MODEL_NAME"; then
    if [ -f "$APP_DIR/Modelfile-aj-mini-v2" ]; then
      echo "Creating model $MODEL_NAME from Modelfile..."
      ollama create $MODEL_NAME -f Modelfile-aj-mini-v2 || true
    else
      echo "Modelfile not found. Skipping model creation."
    fi
  else
    echo "Model $MODEL_NAME already exists."
  fi

  # Start ollama serve in background
  echo "Starting ollama serve..."
  ollama serve &
  OLLAMA_PID=$!
  echo "Ollama PID: $OLLAMA_PID"
else
  echo "ollama not available, continuing. Model calls will fail unless ollama is installed."
fi

# Start Gunicorn for Flask app
echo "Starting gunicorn for API..."
exec gunicorn api_server:app --bind 0.0.0.0:5000 --workers 2
