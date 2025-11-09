# AJ Model Selection Guide

## Available Models

AJ API now supports **3 local AI models** that you can choose from:

### 1. **aj-mini-fast** (Qwen2.5 0.5B)
- ⚡ **Speed**: Ultra-fast (1-2 seconds)
- 🎯 **Best for**: Quick questions, instant responses
- 💻 **System requirements**: Minimal (500MB RAM)
- 🔥 **Response quality**: Good for simple tasks

### 2. **aj-mini-balanced** (DeepSeek-R1 1.5B)
- ⚖️ **Speed**: Balanced (3-5 seconds)
- 🎯 **Best for**: General conversations, moderate complexity
- 💻 **System requirements**: Low (1.5GB RAM)
- 🔥 **Response quality**: Better reasoning than fast

### 3. **aj-mini** (DeepSeek-R1 8B)
- 🧠 **Speed**: Slow (10-30 seconds)
- 🎯 **Best for**: Complex reasoning, detailed analysis
- 💻 **System requirements**: High (8GB RAM)
- 🔥 **Response quality**: Best quality, advanced reasoning

---

## How to Use Model Selection

### Via API (`/api/chat` endpoint)

**Default Model (no model specified):**
```bash
curl -X POST "http://localhost:5000/api/chat" \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello AJ, who created you?"}'
```
> Uses: `aj-mini-fast` (default)

**Specify a Model:**
```bash
curl -X POST "http://localhost:5000/api/chat" \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello AJ, who created you?", "model":"aj-mini-balanced"}'
```

**With ngrok (production):**
```bash
curl -X POST "https://cryptozygous-demetrice-homopolar.ngrok-free.dev/api/chat" \
  -H "Content-Type: application/json" \
  -H "ngrok-skip-browser-warning: true" \
  -d '{"message":"Hello AJ, explain quantum computing", "model":"aj-mini-balanced"}'
```

### Via OpenAI-compatible endpoint (`/v1/chat/completions`)

```bash
curl -X POST "http://localhost:5000/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "aj-mini-balanced",
    "messages": [
      {"role": "user", "content": "What is machine learning?"}
    ]
  }'
```

### Via Web Chatbot

1. Open: https://my-name-aj.vercel.app
2. Look for model selector in the sidebar or settings
3. Choose from: **AJ Mini Fast**, **AJ Mini Balanced**, or **AJ Mini**
4. Start chatting!

---

## PowerShell Examples

### Test aj-mini-fast (fastest)
```powershell
$body = @{
  message = "Hello AJ, who created you?"
  model = "aj-mini-fast"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:5000/api/chat" `
  -Method POST `
  -Body $body `
  -ContentType "application/json"
```

### Test aj-mini-balanced (balanced)
```powershell
$body = @{
  message = "Explain artificial intelligence in simple terms"
  model = "aj-mini-balanced"
} | ConvertTo-Json

Invoke-RestMethod -Uri "https://cryptozygous-demetrice-homopolar.ngrok-free.dev/api/chat" `
  -Method POST `
  -Body $body `
  -ContentType "application/json" `
  -Headers @{"ngrok-skip-browser-warning"="true"}
```

### Test aj-mini (most powerful, slow)
```powershell
$body = @{
  message = "Write a Python function to calculate fibonacci numbers"
  model = "aj-mini"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:5000/api/chat" `
  -Method POST `
  -Body $body `
  -ContentType "application/json"
```

---

## Model Comparison

| Feature | aj-mini-fast | aj-mini-balanced | aj-mini |
|---------|-------------|-----------------|---------|
| Response Time | 1-2s ⚡ | 3-5s ⚖️ | 10-30s 🧠 |
| Model Size | 0.5B | 1.5B | 8B |
| RAM Usage | ~500MB | ~1.5GB | ~8GB |
| Reasoning | Basic | Good | Advanced |
| Best Use | Quick answers | General chat | Complex tasks |
| Cost | FREE ✅ | FREE ✅ | FREE ✅ |
| Privacy | 100% Local 🔒 | 100% Local 🔒 | 100% Local 🔒 |

---

## Response Format

### Success Response
```json
{
  "response": "Hello! I am AJ, a powerful AI assistant created by AJ STUDIOZ...",
  "model": "aj-mini-balanced",
  "creator": "AJ STUDIOZ",
  "timestamp": 1704123456.789
}
```

### Error Response
```json
{
  "error": "Model execution failed",
  "details": "Model not found",
  "returncode": 1
}
```

---

## Tips for Choosing the Right Model

### Use **aj-mini-fast** when:
- You need instant responses
- Question is simple or factual
- Testing API endpoints
- Building conversational apps
- Low system resources

### Use **aj-mini-balanced** when:
- You want good quality without waiting
- Moderate complexity questions
- General conversations
- Best balance of speed and quality
- **RECOMMENDED for most users** ⭐

### Use **aj-mini** when:
- You need the best quality
- Complex reasoning required
- Writing code or detailed analysis
- You have time to wait
- High-end system available

---

## Created by AJ STUDIOZ
- Website: https://ajstudioz.co.in
- Chatbot: https://my-name-aj.vercel.app
- API: https://cryptozygous-demetrice-homopolar.ngrok-free.dev

**FREE • UNLIMITED • PRIVACY-FIRST • OPEN SOURCE**
