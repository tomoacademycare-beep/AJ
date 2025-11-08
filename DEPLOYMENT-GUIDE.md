# AJ Model - Online Deployment Guide

## 🌐 Making AJ Available Online

There are several ways to deploy your AJ model online. Here are the recommended options:

---

## Option 1: Ollama with Public API (Recommended for Testing)

### Step 1: Enable Ollama API Server
```powershell
# Set environment variable to allow external connections
$env:OLLAMA_HOST="0.0.0.0:11434"
ollama serve
```

### Step 2: Use ngrok for Public Access (Quick Setup)
```powershell
# Install ngrok from https://ngrok.com/download
# Or using chocolatey:
choco install ngrok

# Start ngrok tunnel
ngrok http 11434
```

You'll get a public URL like: `https://xxxx-xxx-xxx.ngrok.io`

### Step 3: API Usage
```bash
# Example API call
curl https://your-ngrok-url.ngrok.io/api/generate -d '{
  "model": "aj-mini",
  "prompt": "Hello, who are you?",
  "stream": false
}'
```

---

## Option 2: Deploy on Cloud Server (Recommended for Production)

### A. Deploy on DigitalOcean/AWS/Azure

#### 1. Create a Cloud Server
- OS: Ubuntu 22.04 LTS
- RAM: Minimum 4GB (8GB recommended)
- Storage: 20GB SSD

#### 2. Install Ollama on Server
```bash
# SSH into your server
ssh user@your-server-ip

# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama service
sudo systemctl start ollama
sudo systemctl enable ollama
```

#### 3. Upload Your Model
```bash
# From your local machine, export the model
ollama show aj-mini --modelfile > Modelfile-aj-mini-v2

# Copy to server using SCP
scp Modelfile-aj-mini-v2 user@your-server-ip:/home/user/

# On the server, create the model
ollama create aj-mini -f Modelfile-aj-mini-v2
```

#### 4. Configure Firewall
```bash
# Allow port 11434
sudo ufw allow 11434/tcp
sudo ufw enable
```

#### 5. Set Up Nginx Reverse Proxy (Optional but Recommended)
```bash
# Install Nginx
sudo apt update
sudo apt install nginx

# Create Nginx config
sudo nano /etc/nginx/sites-available/aj-api
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:11434;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
# Enable the site
sudo ln -s /etc/nginx/sites-available/aj-api /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### 6. Add SSL Certificate (Recommended)
```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d your-domain.com
```

---

## Option 3: Deploy with Docker (Cross-Platform)

### 1. Create Dockerfile
```dockerfile
FROM ollama/ollama:latest

# Copy your Modelfile
COPY Modelfile-aj-mini-v2 /root/

# Create the model
RUN ollama serve & sleep 5 && ollama create aj-mini -f /root/Modelfile-aj-mini-v2

EXPOSE 11434

CMD ["ollama", "serve"]
```

### 2. Build and Run
```powershell
# Build Docker image
docker build -t aj-mini-api .

# Run container
docker run -d -p 11434:11434 --name aj-api aj-mini-api
```

### 3. Deploy to Cloud
```bash
# Push to Docker Hub
docker tag aj-mini-api yourusername/aj-mini-api
docker push yourusername/aj-mini-api

# Deploy on any cloud provider supporting Docker
```

---

## Option 4: Create Custom Web API (Python Flask/FastAPI)

### 1. Create API Server
Create `api_server.py`:

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import subprocess
import json

app = FastAPI(title="AJ API", description="AJ STUDIOZ AI Assistant API")

class ChatRequest(BaseModel):
    message: str
    stream: bool = False

class ChatResponse(BaseModel):
    response: str
    model: str = "AJ by AJ STUDIOZ"

@app.post("/api/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    try:
        # Call Ollama
        result = subprocess.run(
            ["ollama", "run", "aj-mini", request.message],
            capture_output=True,
            text=True,
            timeout=30
        )
        
        return ChatResponse(response=result.stdout.strip())
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/")
async def root():
    return {
        "name": "AJ API",
        "version": "2.0",
        "creator": "AJ STUDIOZ",
        "website": "https://ajstudioz.co.in"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

### 2. Install Dependencies
```powershell
pip install fastapi uvicorn
```

### 3. Run API Server
```powershell
python api_server.py
```

### 4. Test API
```powershell
# Using curl
curl -X POST "http://localhost:8000/api/chat" -H "Content-Type: application/json" -d '{\"message\": \"Hello\"}'

# Using PowerShell
Invoke-RestMethod -Uri "http://localhost:8000/api/chat" -Method Post -Body (@{message="Hello"} | ConvertTo-Json) -ContentType "application/json"
```

---

## Option 5: Deploy on Hugging Face Spaces (Free Hosting)

### 1. Create a Space on Hugging Face
- Go to https://huggingface.co/spaces
- Create new Space with Docker

### 2. Create Required Files

**Dockerfile:**
```dockerfile
FROM ollama/ollama:latest

COPY Modelfile-aj-mini-v2 /app/
WORKDIR /app

RUN ollama serve & sleep 10 && ollama create aj-mini -f Modelfile-aj-mini-v2

EXPOSE 7860

CMD ["ollama", "serve"]
```

**README.md:**
```markdown
---
title: AJ - AI Assistant by AJ STUDIOZ
emoji: 🤖
colorFrom: blue
colorTo: purple
sdk: docker
pinned: false
---

# AJ - AI Assistant by AJ STUDIOZ

Built with cutting-edge AI technology by AJ STUDIOZ.
```

### 3. Push to Hugging Face
```powershell
git init
git add .
git commit -m "Initial commit"
git remote add origin https://huggingface.co/spaces/YOUR-USERNAME/aj-mini
git push -u origin main
```

---

## 🔒 Security Recommendations

1. **API Authentication**: Add API key validation
2. **Rate Limiting**: Prevent abuse
3. **HTTPS**: Always use SSL certificates
4. **Firewall**: Restrict unnecessary ports
5. **Monitoring**: Set up logging and alerts

---

## 📊 API Endpoints Reference

### Generate Response
```
POST /api/generate
Content-Type: application/json

{
  "model": "aj-mini",
  "prompt": "Your question here",
  "stream": false
}
```

### Chat Endpoint
```
POST /api/chat
Content-Type: application/json

{
  "model": "aj-mini",
  "messages": [
    {"role": "user", "content": "Hello"}
  ]
}
```

### Model Info
```
GET /api/tags
```

---

## 💡 Next Steps

1. Choose your deployment method
2. Set up the infrastructure
3. Configure domain name
4. Add authentication
5. Monitor usage and performance

---

## 🆘 Support

For deployment support, contact: **AJ STUDIOZ**
Website: https://ajstudioz.co.in

---

**Built by AJ STUDIOZ | Powered by AJ Technology**
