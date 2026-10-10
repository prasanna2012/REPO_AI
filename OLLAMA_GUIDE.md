# Open-Source AI Model Guide with Ollama

RepoAI is built from the ground up to support open-weight coding models. This guide covers supported models, performance tuning, and how Ollama integrates with RepoAI.

---

## 1. Supported Open-Weight Models

| Model | Parameters | License | Recommended Hardware | Best For |
| :--- | :--- | :--- | :--- | :--- |
| **Qwen2.5-Coder-7B-Instruct** | 7.6B | Apache-2.0 | 8GB+ RAM / 6GB+ VRAM | **Default**: Exceptional Python/TS reasoning, bug detection, and diff generation |
| **DeepSeek-Coder-6.7B-Instruct** | 6.7B | DeepSeek License | 8GB+ RAM / 6GB+ VRAM | Algorithmic logic and C++/Java analysis |
| **CodeLlama-7B-Instruct** | 6.9B | Llama 2 Community | 8GB+ RAM / 6GB+ VRAM | Standard multi-language code completion |
| **Llama-3.2-3B-Instruct** | 3.2B | Llama 3.2 Community | 4GB+ RAM (CPU friendly) | Ultra-lightweight devices / laptops without discrete GPU |

---

## 2. Installing Ollama

Ollama is an open-source model runner that exposes a lightweight REST API on port `11434`.

### Installation Commands

- **Windows**: Download installer from [ollama.com/download/windows](https://ollama.com/download/windows).
- **macOS**: Download `.dmg` from [ollama.com/download/mac](https://ollama.com/download/mac).
- **Linux**:
  ```bash
  curl -fsSL https://ollama.com/install.sh | sh
  ```

---

## 3. Pulling Models for RepoAI

```bash
# Recommended default model:
ollama pull qwen2.5-coder:7b

# Alternative low-resource model:
ollama pull llama3.2:3b
```

---

## 4. How RepoAI Interacts with Ollama

RepoAI uses Ollama's native `/api/generate` and `/api/tags` endpoints:

1. **Model Discovery (`GET /api/tags`)**:
   RepoAI polls `http://localhost:11434/api/tags` to list installed models and confirm daemon health.

2. **Grounded Generation (`POST /api/generate`)**:
   RepoAI transmits the indexed file content, system instructions, and target task with parameters:
   - `temperature: 0.2` (for deterministic code output)
   - `stream: false`
   - `system`: RepoAI's Evidence-to-Fix system prompt.

---

## 5. Performance Optimization & GPU Offloading

- **NVIDIA CUDA**: Ollama auto-detects CUDA on Windows and Linux and loads layers to GPU VRAM.
- **Apple Silicon**: Uses Metal on M1/M2/M3/M4 with unified memory for near-instant inference.
- **Context Length Adjustment**:
  If analyzing large repository files, you can increase Ollama's context window:
  ```bash
  OLLAMA_NUM_CTX=16384 ollama run qwen2.5-coder:7b
  ```
