# Windows Local Setup Guide for RepoAI

This guide provides step-by-step instructions to run **RepoAI** locally on Windows with the open-source **Qwen2.5-Coder-7B-Instruct** model via Ollama.

---

## 1. Prerequisites

1. **Windows 10 / 11** (64-bit)
2. **Node.js** (v18.0.0 or higher):
   - Download from [https://nodejs.org/](https://nodejs.org/) (LTS recommended).
   - Verify in Command Prompt: `node -v` and `npm -v`.
3. **Ollama for Windows**:
   - Download the official Windows installer from [https://ollama.com/download/windows](https://ollama.com/download/windows).
   - Run `OllamaSetup.exe` and follow on-screen prompts.
   - Verify in Command Prompt: `ollama -v`.
4. **Git for Windows** (Optional but recommended):
   - Download from [https://git-scm.com/download/win](https://git-scm.com/download/win).

---

## 2. Download Open-Source Coding Model

Open PowerShell or Command Prompt as your standard user and run:

```powershell
# Pull the recommended primary coding model (Qwen2.5-Coder 7B)
ollama pull qwen2.5-coder:7b

# (Optional) Verify that the model runs:
ollama run qwen2.5-coder:7b "Write a Python function to check palindrome strings"
```

> **Hardware note**:
> - If you have an NVIDIA GPU with 6GB+ VRAM, Ollama will automatically use GPU acceleration.
> - If you only have CPU / Integrated graphics, you can use the lightweight version:
>   `ollama pull llama3.2:3b` or `ollama pull qwen2.5-coder:1.5b`.

Ensure Ollama is running in the background. By default, the Ollama icon will be in your Windows System Tray (listening on `http://localhost:11434`).

---

## 3. Clone and Run RepoAI

1. Open PowerShell or Command Prompt:

```powershell
# Navigate to your projects directory
cd C:\Users\%USERNAME%\Projects

# If cloning from GitHub:
git clone https://github.com/your-username/repoai.git
cd repoai
```

2. Install dependencies:

```powershell
npm install
```

3. (Optional) Configure environment variables:
   Copy `.env.example` to `.env`:

```powershell
copy .env.example .env
```

If you wish to use Google Gemini alongside Ollama, add your `GEMINI_API_KEY`:
```env
GEMINI_API_KEY="your_api_key_here"
PORT=3000
OLLAMA_HOST="http://localhost:11434"
```

4. Start RepoAI:

```powershell
npm run dev
```

You should see:
```text
RepoAI server listening on http://0.0.0.0:3000
```

5. Open your browser:
   Visit **[http://localhost:3000](http://localhost:3000)**.

---

## 4. Verification & Testing

1. In the top navigation bar, click the **Model: Qwen2.5-Coder** status badge.
2. Click **Test Ping** to confirm communication between RepoAI and `http://localhost:11434`.
3. Click the sample button **PyVault (Python)** in the top bar.
4. Navigate to the **Evidence-to-Fix** tab to see the 4 detected defects.
5. Click **Accept & Apply Patch** on any defect.
6. Switch to the **Test Sandbox** tab and click **Run All Tests** to watch tests turn green!

---

## 5. Troubleshooting on Windows

| Issue | Cause | Solution |
| :--- | :--- | :--- |
| `Ollama connection refused` | Ollama service is stopped | Launch "Ollama" from Windows Start menu or run `ollama serve` in a terminal. |
| `Port 3000 in use` | Another app is on port 3000 | Set `$env:PORT="3001"` before running `npm run dev`. |
| `High memory usage during inference` | Model size exceeds RAM | Run `ollama run llama3.2:3b` instead of 7B. |
| `Execution policy error on npm` | PowerShell script restriction | Run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` in PowerShell. |
