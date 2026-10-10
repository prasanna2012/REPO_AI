# RepoAI — Open-Source AI Code Understanding and Bug Fixing Assistant

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Framework](https://img.shields.io/badge/Frontend-React_19_+_Vite_+_Tailwind-61dafb.svg)](https://react.dev/)
[![AI Model](https://img.shields.io/badge/Model-Qwen2.5--Coder--7B--Instruct-blueviolet.svg)](https://github.com/QwenLM/Qwen2.5-Coder)
[![Runtime](https://img.shields.io/badge/Runtime-Ollama_Local_/_Gemini-green.svg)](https://ollama.com/)

**RepoAI** is an open-source, AI-powered coding assistant that helps software engineers, students, and code reviewers inspect, understand, and fix source code downloaded from Git repositories or uploaded as ZIP archives.

Instead of acting as a generic conversational chatbot that invents code or hallucinates missing functions, RepoAI introduces a grounded **Evidence-to-Fix workflow**: every bug finding is tied to exact code evidence (culprit line numbers and invariant failure rationale), synthesized into a unified git diff patch, validated through AST syntax checks, and verified against an isolated test runner before developer acceptance.

---

## 1. Problem Statement

Developers frequently download repositories from GitHub or receive unfamiliar legacy archives. They face critical hurdles:
1. **Steep Onboarding Curve**: Understanding multi-file architecture, control flows, and module dependencies takes hours.
2. **AI Slop & Chatbot Hallucinations**: Standard LLMs often invent functions that do not exist in the repository or offer vague pseudo-fixes without considering surrounding code.
3. **Unvalidated Fixes**: AI-generated code snippets frequently contain syntax errors, mismatched brackets, or break neighboring tests.
4. **Security Risks from Untrusted Archives**: Uploaded repositories may contain path traversal attacks (Zip Slip) or malicious scripts that should never execute automatically.

---

## 2. Solution & The Evidence-to-Fix Workflow

RepoAI solves this with an original, 6-stage **Evidence-to-Fix pipeline**:

```text
┌────────────────────────┐      ┌────────────────────────┐      ┌────────────────────────┐
│ 1. Source Retrieval    │ ───> │ 2. Code Evidence       │ ───> │ 3. Proposed Patch      │
│ Indexed files, AST     │      │ Isolates culprit lines │      │ Minimal Unified Diff   │
│ symbols & dependencies │      │ & invariant failures   │      │ targeting defect       │
└────────────────────────┘      └────────────────────────┘      └────────────────────────┘
            │                                                               │
            ▼                                                               ▼
┌────────────────────────┐      ┌────────────────────────┐      ┌────────────────────────┐
│ 6. Developer Decision  │ <─── │ 5. Regression Testing  │ <─── │ 4. AST Validation      │
│ Non-destructive patch  │      │ Synthesizes test case  │      │ Verifies delimiter     │
│ accept, revert, export │      │ & runs sandbox check   │      │ balance & syntax rules │
└────────────────────────┘      └────────────────────────┘      └────────────────────────┘
```

1. **Source Retrieval**: Validates and indexes code files safely, preventing path traversal attacks (`../`).
2. **Code Evidence**: Pinpoints exact line numbers, offending code chunks, and failure triggers.
3. **Proposed Patch**: Generates standard unified diff format (`--- a/... +++ b/... @@ ... @@`).
4. **AST Validation**: Performs structural checks to ensure braces, parentheses, and syntax invariants are intact.
5. **Regression Testing**: Creates or selects test cases reproducing the bug and reports actual execution results.
6. **Developer Decision**: Non-destructively applies or rolls back changes in-memory.

---

## 3. Key Features

- **Repository ZIP & File Upload**:
  - Drag-and-drop entire repository archives (`.zip`) or individual source files.
  - Supports Python, TypeScript, JavaScript, Java, C/C++, HTML, CSS, SQL, JSON, and Markdown.
  - Protects against Zip Slip traversal attacks and excludes binary files.
- **Dual Explanation Modes**:
  - **Simple English**: High-level, beginner-friendly explanation of core purpose and logic.
  - **Technical Deep Dive**: In-depth analysis of algorithms, state transitions, and complexity.
  - Interactive line references that jump directly to source lines in the code viewer.
- **Interactive Grounded Assistant**:
  - Answers questions grounded exclusively in the uploaded codebase.
  - Floating "Send selected code snippet to Assistant" action from the code viewer.
  - Avoids hallucinating missing functions.
- **Isolated Test Sandbox**:
  - Detects test frameworks (Pytest, Vitest/Jest).
  - Demonstrates actual failure traces on buggy code and 100% green runs once patches are applied.
- **Configurable Open-Weight Technology Stack**:
  - Connects locally to **Ollama** (`qwen2.5-coder:7b`, `deepseek-coder:6.7b`, etc.) for 100% private offline inference.
  - Seamless fallback to Google Gemini 3.8 Flash for cloud deployment.

---

## 4. Architecture

```text
├── src/
│   ├── components/
│   │   ├── Navbar.tsx             # Clean 3-zone header & model status
│   │   ├── Sidebar.tsx            # Indexed file tree & search
│   │   ├── CodeViewer.tsx         # Syntax viewer, line jump & selection action
│   │   ├── ExplanationPanel.tsx   # Simple vs. Technical walkthrough
│   │   ├── EvidenceToFixPanel.tsx # 6-stage Evidence-to-Fix workflow
│   │   ├── ChatAssistant.tsx      # Grounded interactive assistant
│   │   ├── TestRunnerPanel.tsx    # Isolated test sandbox & validation
│   │   ├── UploadModal.tsx        # ZIP dropzone & security sanitization
│   │   ├── SettingsModal.tsx      # Local Ollama & model configuration
│   │   ├── ExportModal.tsx        # Markdown audit & git patch export
│   │   └── DocView.tsx            # Project documentation tab
│   ├── demo/
│   │   └── sampleRepos.ts         # Authentic PyVault & TaskFlow demo repos
│   ├── services/
│   │   ├── apiClient.ts           # REST API client with fallback resilience
│   │   ├── evidenceEngine.ts      # AST syntax validator & heuristic auditor
│   │   └── zipParser.ts           # Zip Slip protection & symbol extraction
│   └── types/
│       └── repo.ts                # TypeScript domain models
├── server.ts                      # Express full-stack backend with Vite middleware
├── fastapi_app.py                 # Alternative Python FastAPI backend
├── harness/
│   └── eval_harness.py            # Model evaluation benchmark script
├── skills/
│   └── repoai-code-auditor/       # Agent Skill open standard specification
│       └── SKILL.md
├── SETUP_WINDOWS.md               # Step-by-step Windows setup guide
├── OLLAMA_GUIDE.md                # Open-weight model and Ollama manual
└── LICENSE                        # Apache-2.0
```

---

## 5. Quickstart Guide (Local Windows / Linux / macOS)

### Method A: Full-Stack Node.js (Vite + Express)

1. **Install Ollama and pull Qwen2.5-Coder**:
   ```bash
   ollama pull qwen2.5-coder:7b
   ```
2. **Install dependencies and start development server**:
   ```bash
   npm install
   npm run dev
   ```
3. Open `http://localhost:3000` in your browser.

### Method B: Python FastAPI Backend

If you prefer a pure Python backend for hackathon evaluation:
```bash
pip install -r requirements.txt
python fastapi_app.py
```
FastAPI runs on `http://localhost:8000` with interactive docs at `http://localhost:8000/docs`.

---

## 6. Evaluation & Benchmark Harness

RepoAI includes a standalone model evaluation harness at `harness/eval_harness.py`:

```bash
python harness/eval_harness.py
```

Measures:
- **Defect Localization Precision**: Did the model isolate the exact line numbers containing the bug?
- **Unified Diff Syntactic Validity**: Did the synthesized patch parse without syntax errors?
- **Regression Verification Rate**: Did applying the patch turn failing test cases into passing ones?

---

## 7. Security Guarantees & Untrusted Code Handling

- **Never Execute Uploaded Code Automatically**: Repository files are parsed purely for AST inspection and syntax analysis.
- **Zip Slip Prevention**: All paths inside uploaded archives are stripped of `../` sequences and validated against path canonicalization attacks.
- **Resource Limits**: Single files are capped at 5 MB; total archives are capped at 50 MB to prevent decompression bombs.

---

## 8. License

Licensed under the [Apache-2.0 License](LICENSE).
