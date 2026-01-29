#!/usr/bin/env bash
set -euo pipefail

### 1) Install Ollama (if not already installed)
echo "==> Installing Ollama..."
if ! command -v ollama &>/dev/null; then
  curl -fsSL https://ollama.com/install.sh | sh
  export PATH="$HOME/.ollama/bin:$PATH"
else
  echo "Ollama already installed: $(ollama --version)"
fi

### 2) Verify installation
echo "==> Verifying Ollama..."
ollama --version
export PATH="$HOME/.ollama/bin:$PATH"

### 3) Pull and run the specified Hugging Face GGUF model
MODELS=(
  hf.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF:Q4_K_M
  hf.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF:Q3_K_M
  hf.co/TheBloke/deepseek-coder-6.7B-instruct-GGUF:Q4_K_M
  hf.co/bartowski/Phi-3.5-mini-instruct-GGUF:Q8_0
  hf.co/second-state/StarCoder2-3B-GGUF:Q8_0
  hf.co/TheBloke/CodeLlama-7B-GGUF:Q4_K_M
  hf.co/TheBloke/Orca-2-7B-GGUF:Q4_K_M
)

for model in "${MODELS[@]}"; do
  ollama pull "$model"
done

### 4) Listign Models
echo "==> Listing Models...."
ollama list
