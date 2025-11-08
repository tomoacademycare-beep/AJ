AJ — Free hosting guide (ngrok)

Goal
----
Provide a simple free way to host and share your AJ model API publicly using your local machine + ngrok.

Summary
-------
This method keeps everything on your machine and exposes the running Flask API over a secure ngrok tunnel. It's free but requires your PC to stay on. It's the most practical free approach because the AJ model requires Ollama to be present on the host (not available on most free PaaS).

What you already have
---------------------
- `api_server.py` (Flask API that calls `ollama` locally)
- `Modelfile-aj-mini-v2` (model config)
- Project pushed to GitHub
- `run_local_with_ngrok.ps1` (helper to run API + ngrok persistently)
- ngrok authtoken already configured on your machine

Steps to run (Windows)
----------------------
1. Install Python deps (if not done):

```powershell
pip install -r requirements.txt
```

2. Make sure the `aj-mini` model is available in Ollama and Ollama works:

```powershell
ollama list
ollama run aj-mini "Who are you?"
```

3. Place `ngrok.exe` in your PATH or the same folder as the repo. Ensure you already ran:

```powershell
ngrok config add-authtoken <your-authtoken>
```

4. Run the helper script (PowerShell as Administrator recommended):

```powershell
.\run_local_with_ngrok.ps1
```

This will start the Flask API and an ngrok tunnel on port 5000. The script prints output from both processes. When ngrok starts, it will show the public URL (e.g., `https://xxxx.ngrok-free.app`).

Using the public URL
--------------------
Test with curl (replace with your ngrok URL):

```bash
curl -X POST "https://xxxx.ngrok-free.app/api/chat" -H "Content-Type: application/json" -d '{"message":"Who are you?"}'
```

Notes & Limitations
-------------------
- Your PC must be ON and running the script to keep the model online.
- ngrok free URLs rotate each session (if you need a stable subdomain you need a paid ngrok plan).
- For production-level reliability, use a VPS where you can install Ollama and run the model (not free).

If you want, I can prepare a small DigitalOcean script to automate the full deployment (paid) or prepare a Dockerfile for a larger host (may exceed free-tier limits).