# AJ API + ngrok Setup Guide

## Quick Start (Windows)

### Prerequisites
- ✅ **Ollama** installed with `aj-mini` model
- ✅ **ngrok** installed and in PATH
- ✅ Python 3.8+

### Step 1: Run the Launcher

**Option A - Simple (Recommended):**
```
Double-click:  start_ngrok.bat
```

**Option B - Manual:**
```powershell
# Open PowerShell in this directory and run:
.\start_ngrok.ps1
```

### Step 2: View Your Public URL

Once running, open your browser to:
```
http://localhost:4040
```

You'll see your ngrok tunnel with a public URL like:
```
https://1234-567-890-12.ngrok.io
```

### Step 3: Test Your API

**Get Home (Status Check):**
```bash
curl https://YOUR_NGROK_URL/
```

**Chat with AJ:**
```bash
curl -X POST https://YOUR_NGROK_URL/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello, how are you?"}'
```

**Get Model Info:**
```bash
curl https://YOUR_NGROK_URL/api/info
```

---

## How It Works

1. **Flask API** starts on `http://localhost:5000`
   - Runs `api_server.py` locally
   - Uses Ollama + aj-mini model for responses

2. **ngrok tunnel** exposes port 5000 publicly
   - Creates a public HTTPS URL
   - Tunnels requests to your local Flask server
   - Free tier: Good for testing/development

3. **API Endpoints:**
   - `GET  /` → Health check & info
   - `POST /api/chat` → Send message to AJ
   - `GET  /api/info` → Model details

---

## Important Notes

- ⚠️ **Your PC must stay ON** for the API to remain accessible
- ⚠️ **ngrok URL changes** each time you restart (unless you have a paid plan)
- ✅ **CORS enabled** - works with web frontends
- ✅ **Free forever** - ngrok free tier is sufficient for testing

---

## Example Frontend Integration

```html
<script>
  const API_URL = 'https://YOUR_NGROK_URL'; // Replace with your ngrok URL

  async function sendMessage(message) {
    const response = await fetch(`${API_URL}/api/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message: message })
    });
    const data = await response.json();
    return data.response;
  }
</script>
```

---

## Troubleshooting

**Flask not starting?**
- Ensure Ollama is running: `ollama serve`
- Check if model exists: `ollama list | grep aj-mini`

**ngrok not working?**
- Ensure you have ngrok installed: `ngrok version`
- Check if port 5000 is free: `netstat -ano | findstr :5000`

**Public URL changes after restart?**
- This is normal. Get the new URL from http://localhost:4040

---

## When Ready for Production

- Consider **Render** or **Railway** with a proper AI API service
- Or keep using ngrok for development/testing
- See `DEPLOYMENT-GUIDE.md` for production options
