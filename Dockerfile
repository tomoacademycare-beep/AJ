# Dockerfile for AJ API + Ollama
# NOTE: This Docker image must include Ollama and your model blobs.
# Building this image locally (on your machine where Ollama and model blobs exist) and pushing
# to a registry (Docker Hub) is the recommended approach.

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Install basic deps
RUN apt-get update \
  && apt-get install -y curl ca-certificates python3 python3-pip python3-venv git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Ollama (official installer)
# The Ollama installer may place binaries in /usr/local/bin
RUN curl -fsSL https://ollama.com/install.sh | sh || true

# Create app directory
WORKDIR /app

# Copy project files
COPY . /app

# Install Python deps
RUN python3 -m pip install --upgrade pip setuptools
RUN if [ -f requirements.txt ]; then python3 -m pip install -r requirements.txt; fi

# Make start script executable
RUN chmod +x /app/start.sh

# Expose ports
# 5000 - Flask API (gunicorn)
# 11434 - Ollama serve API (if used directly)
EXPOSE 5000 11434

# Start command
CMD ["/app/start.sh"]
