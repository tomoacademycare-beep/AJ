# 🚀 AJ STUDIOZ - Production Deployment Guide

## Overview
Connect your deployed Vercel chatbot to your local AJ AI models for FREE unlimited AI responses!

---

## 🎯 How It Works

1. **Local Server**: Your PC runs the AJ models (aj-mini-fast or aj-mini)
2. **ngrok Tunnel**: Creates a public HTTPS URL to your local server
3. **Vercel Chatbot**: Your deployed chatbot connects to this URL
4. **Result**: Free unlimited AI with your own models!

---

## 📋 Step-by-Step Setup

### Step 1: Start Your Local AI Server

**For Fast Responses (Recommended):**
- Double-click `D:\Desktop\AJ-mini-fast.lnk`
- Wait for the server to start
- Copy the ngrok URL shown (e.g., `https://xxxx-xx-xxx.ngrok-free.app`)

**For Powerful Responses:**
- Double-click `D:\Desktop\AJ-mini-pro.lnk`
- Wait for the server to start
- Copy the ngrok URL shown

### Step 2: Configure Vercel Environment Variable

1. Go to your Vercel dashboard: https://vercel.com/dashboard
2. Select your chatbot project (aj-studioz-06)
3. Click **Settings** → **Environment Variables**
4. Add new variable:
   ```
   Name: OLLAMA_BASE_URL
   Value: https://your-ngrok-url.ngrok-free.app
   ```
   (Replace with the actual ngrok URL from Step 1)
5. Click **Save**
6. Go to **Deployments** → Click **Redeploy** on latest deployment

### Step 3: Test Connection

1. Visit your deployed chatbot URL
2. Click the settings icon (⚙️) in the chat interface
3. Look for "Server Status" indicator:
   - 🟢 **Green**: Connected to local AI
   - 🔴 **Red**: Disconnected (check if local server is running)
4. Select "AJ Mini Fast" or "AJ Mini" from model dropdown
5. Send a message - it should respond using your local AI!

---

## 🖥️ Desktop Shortcuts

You now have **4 shortcuts** on your desktop:

1. **AJ-mini-fast.lnk**: Start fast AI server (instant responses)
2. **AJ-mini-pro.lnk**: Start powerful AI server (better quality)
3. **AJ-Chat.lnk**: Simple HTML chat interface (local only)
4. **AJ-Chatbot.lnk**: Full Next.js chatbot (local development)

---

## 🌍 Usage Scenarios

### Scenario 1: Local Development
- Double-click `AJ-Chatbot.lnk`
- Chatbot runs on http://localhost:3000
- Uses local Ollama (no ngrok needed)
- Perfect for testing

### Scenario 2: Production (Vercel)
1. Start `AJ-mini-fast.lnk` (keep it running)
2. Copy ngrok URL from terminal
3. Add to Vercel environment variables
4. Redeploy your chatbot
5. Now your live website uses your PC's AI!

---

## 📊 Server Status Indicator

Your chatbot now shows real-time server connection status:

```
Settings → Server Status
🟢 AJ Local AI: Connected
   Server: https://xxxx.ngrok-free.app
   Models: aj-mini-fast, aj-mini
```

If disconnected:
```
🔴 AJ Local AI: Offline
   Cannot connect to Ollama server
```

---

## 🔧 Troubleshooting

### Issue: "Cannot connect to Ollama server"
**Solution:**
1. Make sure you started one of the desktop shortcuts (AJ-mini-fast or AJ-mini-pro)
2. Check if ngrok is running (you should see the ngrok dashboard)
3. Verify the OLLAMA_BASE_URL in Vercel matches your ngrok URL
4. Redeploy on Vercel after changing environment variables

### Issue: "Slow responses"
**Solution:**
- Use **AJ-mini-fast** instead of AJ-mini-pro
- First request is always slower (model loading)
- Subsequent requests will be much faster

### Issue: "ngrok URL keeps changing"
**Solution:**
- Free ngrok URLs change on restart
- Use a paid ngrok account for permanent URLs
- Or update Vercel environment variable when URL changes

### Issue: "Vercel deployment not using new URL"
**Solution:**
1. After changing OLLAMA_BASE_URL in Vercel
2. You MUST redeploy (not just save)
3. Go to Deployments → Click "Redeploy" on latest

---

## 💡 Tips

1. **Keep your PC running**: The local server must be running for production chatbot to work
2. **Battery/Sleep**: Disable sleep mode or use a desktop PC
3. **Internet required**: Both your PC and visitors need internet
4. **Free forever**: No API costs, unlimited requests!
5. **Privacy**: Your data stays on your PC (except when tunneling via ngrok)

---

## 🎉 You're All Set!

Your setup:
- ✅ Local AI models (aj-mini-fast, aj-mini)
- ✅ API servers with ngrok tunneling
- ✅ Desktop shortcuts for easy start
- ✅ Next.js chatbot with Ollama integration
- ✅ Production-ready with Vercel support
- ✅ Server status indicator
- ✅ Free unlimited AI responses!

---

## 📞 Support

Created by **AJ STUDIOZ**
Website: https://ajstudioz.co.in

Enjoy your free, unlimited AI chatbot! 🚀
