# 🚀 AJ + ngrok - START HERE

## ⚡ Quick Start (3 Simple Steps)

### Step 1: Start Everything
**Double-click:** `QUICK_START.bat`

You'll see two windows open in the background:
- Flask API (localhost:5000)
- ngrok tunnel

### Step 2: Get Your Public URL
Open your browser and go to:
```
http://localhost:4040
```

You'll see a page showing your PUBLIC ngrok URL like:
```
https://1a2b3c4d5e6f-abcd.ngrok.io
```

**Copy this URL!**

### Step 3: Connect & Chat
**Open `index.html` in your browser**

1. Paste your ngrok URL into the **"📡 ngrok API URL Configuration"** field
2. Click **"Save URL"**
3. Wait for **"✅ Connected!"** status
4. Type your message and press Send!

---

## ✅ Checklist

- [ ] Running `QUICK_START.bat`
- [ ] API and ngrok are running (check with Task Manager)
- [ ] Got ngrok URL from `http://localhost:4040`
- [ ] Opened `index.html` in browser
- [ ] Pasted ngrok URL and clicked Save
- [ ] Chatting with AJ!

---

## 🎯 What's Running

| Service | URL | Purpose |
|---------|-----|---------|
| **Flask API** | `http://localhost:5000` | Local AI API (aj-mini) |
| **ngrok Dashboard** | `http://localhost:4040` | View your public URL |
| **Web Interface** | Open `index.html` | Chat with AJ |
| **Public URL** | `https://xxxxx.ngrok.io` | Your public API endpoint |

---

## 📝 Example Chat

**You:** "Hello, how are you?"

**AJ:** (Uses aj-mini model to reply perfectly with context-aware response)

---

## ⚠️ Important Notes

- Your **PC must stay ON** for the API to be accessible
- Your **ngrok URL changes** when you restart services (this is normal)
- The **public URL expires** after 7 days if unused (free tier)
- **CORS is enabled** - works with any frontend

---

## 🔧 Troubleshooting

**"Connection failed" in web interface?**
- Check ngrok URL is correct (from `http://localhost:4040`)
- Make sure you clicked "Save URL"
- Verify both services are running

**"API not responding" error?**
- Check if Flask is running (Task Manager → search "python")
- Restart `QUICK_START.bat`

**Web page won't load?**
- Right-click `index.html` → Open with Browser
- Or drag-drop into browser
- Try clearing browser cache (Ctrl+Shift+Delete)

**ngrok URL keeps changing?**
- This is normal for free tier
- Get the new URL from `http://localhost:4040` each time

---

## 🎓 How It Works

```
Your Questions
     ↓
index.html (Web UI)
     ↓
ngrok tunnel (HTTPS)
     ↓
Flask API (localhost:5000)
     ↓
Ollama + aj-mini Model
     ↓
Perfect AI Response ✨
```

---

## 📖 Files Explained

| File | Purpose |
|------|---------|
| `QUICK_START.bat` | Launches everything (use this!) |
| `index.html` | Web interface for chatting |
| `api_server.py` | Flask API backend |
| `start_ngrok.ps1` | PowerShell launcher (advanced) |
| `NGROK-SETUP.md` | Detailed setup guide |

---

## 🚀 When You're Ready for Production

Instead of ngrok (which requires your PC to stay on), deploy to:
- **Render.com** - Connect to a proper AI API service (Groq, HuggingFace, etc.)
- **Railway.app** - Similar to Render
- See `DEPLOYMENT-GUIDE.md` for full production options

---

**Questions?** Check the other .md files for detailed guides!
