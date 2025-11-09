# 🎯 Quick Start Guide - Production Setup

## 1️⃣ Start Your Local Server

**Double-click one of these on your desktop:**
- `AJ-mini-fast.lnk` (Recommended - Fast responses)
- `AJ-mini-pro.lnk` (Powerful but slower)

**You'll see:**
```
===================================================
   AJ FAST SERVER READY!
===================================================

PUBLIC URL: https://abc123-xx-xxx.ngrok-free.app/api/chat

===================================================
   FOR VERCEL CHATBOT PRODUCTION
===================================================

Add this to your Vercel Environment Variables:

OLLAMA_BASE_URL = https://abc123-xx-xxx.ngrok-free.app

Then your deployed chatbot will connect to this!
```

## 2️⃣ Copy the ngrok URL

Copy this part: `https://abc123-xx-xxx.ngrok-free.app`

## 3️⃣ Add to Vercel

1. Go to https://vercel.com/dashboard
2. Click your project (aj-studioz-06)
3. Click **Settings** → **Environment Variables**
4. Click **Add New**
5. Fill in:
   - **Name**: `OLLAMA_BASE_URL`
   - **Value**: `https://abc123-xx-xxx.ngrok-free.app` (your ngrok URL)
   - **Environment**: Production, Preview, Development (check all)
6. Click **Save**

## 4️⃣ Redeploy

1. Go to **Deployments** tab
2. Click the **︙** menu on latest deployment
3. Click **Redeploy**
4. Wait ~30 seconds

## 5️⃣ Test Connection

1. Visit your deployed chatbot URL
2. Click the **user icon** (bottom of sidebar)
3. Look for status indicator:

   **✅ Connected (Green):**
   ```
   🟢 AJ Local AI
      Status: AJ Local AI is connected
      Server: https://abc123.ngrok-free.app
      Models: 2 available
   ```

   **❌ Disconnected (Red):**
   ```
   🔴 AJ Local AI
      Status: Cannot connect to Ollama server
      💡 To use local AI: Double-click AJ-mini-fast on desktop
   ```

## 6️⃣ Use Your AI!

1. Click **model selector** (bottom left corner)
2. Choose:
   - **AJ Mini Fast** → Your local AI (instant!)
   - **AJ Mini** → Your local AI (powerful!)
3. Type a message
4. Get response from YOUR PC! 🎉

---

## 🔄 Important Notes

### Your Server Must Stay Running
- The AJ-mini-fast or AJ-mini-pro window must stay open
- Your PC must be online
- If you close it, production users can't use local AI (but cloud models still work)

### URL Changes on Restart
- Free ngrok URLs are temporary
- If you close and reopen the server, URL changes
- Update Vercel environment variable with new URL
- Or get permanent URL with ngrok paid plan

### Model Selection for Users
Your production users can choose:
- **AJ Mini Fast** (your PC) - Instant, free
- **AJ Mini** (your PC) - Powerful, free
- **TOMO R1** (cloud) - Free (no API key needed)
- **GPT-4o, Claude, etc.** (cloud) - Need API keys

---

## 🎨 What Your Users See

### Bottom Left: Model Selector
```
┌─────────────────┐
│  AJ Mini Fast ▼ │  ← Click to change model
└─────────────────┘
```

### User Menu: Server Status
```
👤 User Menu
   ├── Copy User ID
   ├── Edit User ID
   ├──────────────
   ├── 🟢 AJ Local AI       ← Real-time status
   │   Status: Connected
   │   Server: https://xxx.ngrok-free.app
   │   Models: 2 available
   ├──────────────
   ├── ⚙️ MCP Settings
   ├── 🔑 API Keys
   └── ⭐ Theme
```

---

## 🚀 Testing Checklist

- [ ] Started AJ-mini-fast or AJ-mini-pro
- [ ] Copied ngrok URL
- [ ] Added OLLAMA_BASE_URL to Vercel
- [ ] Redeployed on Vercel
- [ ] Opened deployed chatbot URL
- [ ] Status shows 🟢 Green (connected)
- [ ] Selected "AJ Mini Fast" model
- [ ] Sent test message
- [ ] Got response from local AI

---

## 🆘 Troubleshooting

### Status is Red 🔴
1. Check if AJ-mini-fast/pro window is still open
2. Check if URL in Vercel matches ngrok URL
3. Make sure you redeployed after adding URL
4. Try clicking "Refresh" in status indicator

### Vercel Shows Old URL
1. Update environment variable
2. **Must click Redeploy** (just saving isn't enough)
3. Wait 30 seconds for deployment
4. Hard refresh browser (Ctrl+Shift+R)

### Model Not in Dropdown
1. Make sure Ollama is running (check AJ-mini-fast window)
2. Run: `ollama list` in terminal to verify models exist
3. Should see: aj-mini-fast and aj-mini

---

## 🎉 Success!

When everything works:
- ✅ Your PC serves AI to the world
- ✅ Free unlimited requests
- ✅ No monthly costs
- ✅ Full control
- ✅ Real-time status monitoring

**Your chatbot is now production-ready!** 🚀

---

**Created by AJ STUDIOZ**
For detailed docs, read: PRODUCTION-DEPLOYMENT-GUIDE.md
