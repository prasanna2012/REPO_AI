# How to Run RepoAI in Visual Studio Code

This guide walks you through running and debugging **RepoAI** in **VS Code** on Windows, macOS, or Linux.

---

## Quick Method (Under 2 Minutes)

### 1. Open the Project in VS Code
- Open **VS Code**.
- Click **File > Open Folder...** (or `Ctrl+K Ctrl+O` / `Cmd+O`).
- Select the `repoai` root folder (where `package.json` is located).

---

### 2. Open the Integrated Terminal
- Press **``Ctrl + ` ``** (or `Cmd + ` ` on macOS) or go to **Terminal > New Terminal** in the top menu.

---

### 3. Install Dependencies
In the terminal, run:
```bash
npm install
```
*(This installs React, Vite, Express, and required tools in `node_modules`.)*

---

### 4. Create Your `.env` File
Copy `.env.example` to `.env`:

- **Windows (PowerShell)**:
  ```powershell
  Copy-Item .env.example .env
  ```
- **Windows (CMD)**:
  ```cmd
  copy .env.example .env
  ```
- **macOS / Linux**:
  ```bash
  cp .env.example .env
  ```

*(Optional: Add your `GEMINI_API_KEY="..."` in `.env` if you want Google Gemini cloud fallback alongside local Ollama).*

---

### 5. Start the Application

You have two easy ways to start:

#### Option A: Run via Terminal (Recommended)
In the VS Code terminal, run:
```bash
npm run dev
```

#### Option B: Run with F5 (Run & Debug)
1. Press **`F5`** on your keyboard (or click the **Run and Debug** icon on the left sidebar).
2. Select **`RepoAI (Dev Server)`**.
3. VS Code will automatically start the server in your integrated terminal.

---

### 6. View the Application
Once the terminal outputs:
```text
RepoAI server listening on http://0.0.0.0:3000
```
- Open your web browser and go to: **[http://localhost:3000](http://localhost:3000)**.
- You can also hold `Ctrl` (or `Cmd`) and click the `http://localhost:3000` link directly inside the VS Code terminal.

---

## (Optional) Running Local Open-Source AI (Ollama)

If you want to use the offline open-weight model (**Qwen2.5-Coder-7B**):

1. Make sure Ollama is installed from [https://ollama.com](https://ollama.com).
2. In a separate terminal or PowerShell tab in VS Code:
   ```bash
   ollama run qwen2.5-coder:7b
   ```
3. In RepoAI (at `http://localhost:3000`), click the **Model** badge in the navbar and click **Test Ping**. It will turn green!

---

## (Optional) Running the Python FastAPI Backend in VS Code

If your hackathon judge asks to see the Python FastAPI backend:

1. In VS Code terminal:
   ```bash
   pip install -r requirements.txt
   python fastapi_app.py
   ```
2. Open **[http://localhost:8000/docs](http://localhost:8000/docs)** to view the interactive FastAPI Swagger documentation.

---

## Useful Keyboard Shortcuts in VS Code

| Action | Windows / Linux | macOS |
| :--- | :--- | :--- |
| **Open Integrated Terminal** | `Ctrl + ` ` | `Cmd + ` ` |
| **Start Debugging (F5)** | `F5` | `F5` |
| **Restart Dev Server** | `Ctrl + Shift + F5` | `Cmd + Shift + F5` |
| **Stop Server** | `Ctrl + C` in terminal | `Ctrl + C` in terminal |
| **Quick File Search** | `Ctrl + P` | `Cmd + P` |
