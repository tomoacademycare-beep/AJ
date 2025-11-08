"""
AJ API Server
Created by AJ STUDIOZ
Simple REST API for AJ AI Assistant
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess
import json
import os

app = Flask(__name__)
CORS(app)  # Enable CORS for web access

# API Configuration
API_VERSION = "2.0"
MODEL_NAME = "aj-mini"

@app.route('/')
def home():
    """API Homepage"""
    return jsonify({
        "name": "AJ API",
        "version": API_VERSION,
        "model": MODEL_NAME,
        "creator": "AJ STUDIOZ",
        "website": "https://ajstudioz.co.in",
        "status": "online",
        "endpoints": {
            "POST /api/chat": "Send a message to AJ",
            "GET /api/info": "Get model information",
            "GET /health": "Health check"
        }
    })

@app.route('/api/chat', methods=['POST'])
def chat():
    """Chat with AJ"""
    try:
        data = request.get_json()
        
        if not data or 'message' not in data:
            return jsonify({
                "error": "Missing 'message' field in request"
            }), 400
        
        user_message = data['message']
        
        # Call Ollama to get response (increased timeout to 120 seconds for model loading)
        result = subprocess.run(
            ['ollama', 'run', MODEL_NAME, user_message],
            capture_output=True,
            text=True,
            timeout=120
        )
        
        if result.returncode != 0:
            error_msg = result.stderr if result.stderr else "Unknown error"
            return jsonify({
                "error": "Model execution failed",
                "details": error_msg,
                "returncode": result.returncode
            }), 500
        
        response_text = result.stdout.strip()
        
        if not response_text:
            return jsonify({
                "error": "Model returned empty response",
                "details": "The model processed the message but returned no text"
            }), 500
        
        return jsonify({
            "response": response_text,
            "model": MODEL_NAME,
            "creator": "AJ STUDIOZ"
        })
        
    except subprocess.TimeoutExpired:
        return jsonify({
            "error": "Request timeout - model took too long to respond",
            "details": "The model needs more than 120 seconds. Try a simpler question or restart the API."
        }), 504
    except Exception as e:
        return jsonify({
            "error": str(e),
            "type": type(e).__name__
        }), 500

@app.route('/api/info', methods=['GET'])
def info():
    """Get model information"""
    try:
        result = subprocess.run(
            ['ollama', 'show', MODEL_NAME],
            capture_output=True,
            text=True,
            timeout=10
        )
        
        return jsonify({
            "model": MODEL_NAME,
            "creator": "AJ STUDIOZ",
            "version": API_VERSION,
            "website": "https://ajstudioz.co.in",
            "status": "available" if result.returncode == 0 else "unavailable"
        })
    except Exception as e:
        return jsonify({
            "error": str(e)
        }), 500

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        "status": "healthy",
        "service": "AJ API",
        "creator": "AJ STUDIOZ"
    })

@app.errorhandler(404)
def not_found(e):
    return jsonify({
        "error": "Endpoint not found",
        "available_endpoints": ["/", "/api/chat", "/api/info", "/health"]
    }), 404

if __name__ == '__main__':
    print("=" * 50)
    print("🚀 AJ API Server - Created by AJ STUDIOZ")
    print("=" * 50)
    print(f"📡 Starting server on http://0.0.0.0:5000")
    print(f"🤖 Model: {MODEL_NAME}")
    print(f"🌐 Website: https://ajstudioz.co.in")
    print("=" * 50)
    
    # Run the server
    # For production, use a WSGI server like gunicorn
    app.run(host='0.0.0.0', port=5000, debug=False)
