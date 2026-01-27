#!/usr/bin/env bash

set -e

MODEL="hf.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF:Q4_0"

echo "Pulling model: $MODEL"
ollama pull "$MODEL"

echo "Running model..."
ollama run "$MODEL"
