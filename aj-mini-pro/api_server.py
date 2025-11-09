"""
AJ API Server - Enhanced Edition
Created by AJ STUDIOZ
Advanced REST API for AJ AI Assistant with Streaming Support
"""

from flask import Flask, request, jsonify, Response, stream_with_context
from flask_cors import CORS
import subprocess
import json
import os
import time

app = Flask(__name__)
CORS(app)  # Enable CORS for web access

# API Configuration
API_VERSION = "3.0"
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
            "POST /api/chat": "Send a message to AJ (supports streaming)",
            "POST /api/chat?stream=true": "Send a message with streaming response",
            "GET /api/info": "Get model information",
            "GET /api/models": "List available models",
            "GET /health": "Health check"
        },
        "features": [
            "Streaming responses",
            "CORS enabled",
            "Error handling",
            "Timeout protection"
        ]
    })

@app.route('/api/chat', methods=['POST'])
def chat():
    """Chat with AJ - Supports streaming"""
    try:
        data = request.get_json()
        
        if not data or 'message' not in data:
            return jsonify({
                "error": "Missing 'message' field in request"
            }), 400
        
        user_message = data['message']
        stream = request.args.get('stream', 'false').lower() == 'true'
        
        # If streaming is requested
        if stream:
            def generate():
                try:
                    # Use Ollama API for streaming
                    process = subprocess.Popen(
                        ['ollama', 'run', MODEL_NAME, user_message],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True,
                        bufsize=1
                    )
                    
                    # Stream output line by line
                    for line in process.stdout:
                        if line.strip():
                            chunk = {
                                "chunk": line.strip(),
                                "model": MODEL_NAME,
                                "done": False
                            }
                            yield f"data: {json.dumps(chunk)}\n\n"
                    
                    process.wait()
                    
                    # Send completion signal
                    final = {
                        "chunk": "",
                        "model": MODEL_NAME,
                        "done": True
                    }
                    yield f"data: {json.dumps(final)}\n\n"
                    
                except Exception as e:
                    error = {
                        "error": str(e),
                        "done": True
                    }
                    yield f"data: {json.dumps(error)}\n\n"
            
            return Response(
                stream_with_context(generate()),
                mimetype='text/event-stream',
                headers={
                    'Cache-Control': 'no-cache',
                    'X-Accel-Buffering': 'no'
                }
            )
        
        # Non-streaming response
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
            "creator": "AJ STUDIOZ",
            "timestamp": time.time()
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

@app.route('/api/models', methods=['GET'])
def list_models():
    """List available Ollama models"""
    try:
        result = subprocess.run(
            ['ollama', 'list'],
            capture_output=True,
            text=True,
            timeout=10
        )
        
        if result.returncode == 0:
            return jsonify({
                "current_model": MODEL_NAME,
                "available_models": result.stdout,
                "creator": "AJ STUDIOZ"
            })
        else:
            return jsonify({
                "error": "Failed to list models",
                "current_model": MODEL_NAME
            }), 500
    except Exception as e:
        return jsonify({
            "error": str(e)
        }), 500

@app.route('/v1/chat/completions', methods=['POST'])
def chat_completions():
    """OpenAI-compatible chat completions endpoint"""
    try:
        data = request.get_json()
        
        if not data or 'messages' not in data:
            return jsonify({
                "error": "Missing 'messages' field in request"
            }), 400
        
        # Extract the last user message
        messages = data['messages']
        user_message = ""
        for msg in reversed(messages):
            if msg.get('role') == 'user':
                user_message = msg.get('content', '')
                break
        
        if not user_message:
            return jsonify({
                "error": "No user message found"
            }), 400
        
        stream = data.get('stream', False)
        
        # If streaming is requested
        if stream:
            def generate():
                try:
                    process = subprocess.Popen(
                        ['ollama', 'run', MODEL_NAME, user_message],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True,
                        bufsize=1
                    )
                    
                    for line in process.stdout:
                        if line.strip():
                            chunk = {
                                "id": "chatcmpl-" + str(time.time()),
                                "object": "chat.completion.chunk",
                                "created": int(time.time()),
                                "model": MODEL_NAME,
                                "choices": [{
                                    "index": 0,
                                    "delta": {"content": line.strip()},
                                    "finish_reason": None
                                }]
                            }
                            yield f"data: {json.dumps(chunk)}\n\n"
                    
                    process.wait()
                    
                    final = {
                        "id": "chatcmpl-" + str(time.time()),
                        "object": "chat.completion.chunk",
                        "created": int(time.time()),
                        "model": MODEL_NAME,
                        "choices": [{
                            "index": 0,
                            "delta": {},
                            "finish_reason": "stop"
                        }]
                    }
                    yield f"data: {json.dumps(final)}\n\n"
                    yield "data: [DONE]\n\n"
                    
                except Exception as e:
                    error = {
                        "error": {"message": str(e), "type": "server_error"}
                    }
                    yield f"data: {json.dumps(error)}\n\n"
            
            return Response(
                stream_with_context(generate()),
                mimetype='text/event-stream',
                headers={
                    'Cache-Control': 'no-cache',
                    'X-Accel-Buffering': 'no'
                }
            )
        
        # Non-streaming response
        result = subprocess.run(
            ['ollama', 'run', MODEL_NAME, user_message],
            capture_output=True,
            text=True,
            timeout=120
        )
        
        if result.returncode != 0:
            return jsonify({
                "error": {"message": "Model execution failed", "type": "server_error"}
            }), 500
        
        response_text = result.stdout.strip()
        
        return jsonify({
            "id": "chatcmpl-" + str(time.time()),
            "object": "chat.completion",
            "created": int(time.time()),
            "model": MODEL_NAME,
            "choices": [{
                "index": 0,
                "message": {
                    "role": "assistant",
                    "content": response_text
                },
                "finish_reason": "stop"
            }],
            "usage": {
                "prompt_tokens": 0,
                "completion_tokens": 0,
                "total_tokens": 0
            }
        })
        
    except Exception as e:
        return jsonify({
            "error": {"message": str(e), "type": "server_error"}
        }), 500

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        "status": "healthy",
        "service": "AJ API Pro",
        "version": API_VERSION,
        "model": MODEL_NAME,
        "creator": "AJ STUDIOZ",
        "uptime": time.time()
    })

@app.errorhandler(404)
def not_found(e):
    return jsonify({
        "error": "Endpoint not found",
        "available_endpoints": [
            "/",
            "/api/chat",
            "/api/chat?stream=true",
            "/api/info",
            "/api/models",
            "/health",
            "/v1/chat/completions"
        ]
    }), 404

@app.route('/v1/chat/completions', methods=['POST'])
@app.route('/chat/completions', methods=['POST'])
def openai_chat_completions():
    """OpenAI-compatible chat completions endpoint"""
    try:
        data = request.get_json()
        
        if not data or 'messages' not in data:
            return jsonify({
                "error": {
                    "message": "Missing 'messages' field in request",
                    "type": "invalid_request_error"
                }
            }), 400
        
        # Extract the last user message
        messages = data.get('messages', [])
        user_message = ""
        for msg in reversed(messages):
            if msg.get('role') == 'user':
                user_message = msg.get('content', '')
                break
        
        if not user_message:
            return jsonify({
                "error": {
                    "message": "No user message found",
                    "type": "invalid_request_error"
                }
            }), 400
        
        stream = data.get('stream', False)
        model = data.get('model', MODEL_NAME)
        
        # If streaming is requested
        if stream:
            def generate():
                try:
                    process = subprocess.Popen(
                        ['ollama', 'run', MODEL_NAME, user_message],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True,
                        bufsize=1
                    )
                    
                    full_response = ""
                    for line in process.stdout:
                        if line.strip():
                            full_response += line
                            chunk = {
                                "id": f"chatcmpl-{int(time.time())}",
                                "object": "chat.completion.chunk",
                                "created": int(time.time()),
                                "model": model,
                                "choices": [{
                                    "index": 0,
                                    "delta": {"content": line},
                                    "finish_reason": None
                                }]
                            }
                            yield f"data: {json.dumps(chunk)}\n\n"
                    
                    process.wait()
                    
                    # Send final chunk
                    final = {
                        "id": f"chatcmpl-{int(time.time())}",
                        "object": "chat.completion.chunk",
                        "created": int(time.time()),
                        "model": model,
                        "choices": [{
                            "index": 0,
                            "delta": {},
                            "finish_reason": "stop"
                        }]
                    }
                    yield f"data: {json.dumps(final)}\n\n"
                    yield "data: [DONE]\n\n"
                    
                except Exception as e:
                    error = {
                        "error": {
                            "message": str(e),
                            "type": "server_error"
                        }
                    }
                    yield f"data: {json.dumps(error)}\n\n"
            
            return Response(
                stream_with_context(generate()),
                mimetype='text/event-stream',
                headers={
                    'Cache-Control': 'no-cache',
                    'X-Accel-Buffering': 'no'
                }
            )
        
        # Non-streaming response
        result = subprocess.run(
            ['ollama', 'run', MODEL_NAME, user_message],
            capture_output=True,
            text=True,
            timeout=120
        )
        
        if result.returncode != 0:
            return jsonify({
                "error": {
                    "message": "Model execution failed",
                    "type": "server_error"
                }
            }), 500
        
        response_text = result.stdout.strip()
        
        if not response_text:
            return jsonify({
                "error": {
                    "message": "Model returned empty response",
                    "type": "server_error"
                }
            }), 500
        
        return jsonify({
            "id": f"chatcmpl-{int(time.time())}",
            "object": "chat.completion",
            "created": int(time.time()),
            "model": model,
            "choices": [{
                "index": 0,
                "message": {
                    "role": "assistant",
                    "content": response_text
                },
                "finish_reason": "stop"
            }],
            "usage": {
                "prompt_tokens": len(user_message.split()),
                "completion_tokens": len(response_text.split()),
                "total_tokens": len(user_message.split()) + len(response_text.split())
            }
        })
        
    except subprocess.TimeoutExpired:
        return jsonify({
            "error": {
                "message": "Request timeout",
                "type": "timeout_error"
            }
        }), 504
    except Exception as e:
        return jsonify({
            "error": {
                "message": str(e),
                "type": "server_error"
            }
        }), 500

@app.errorhandler(404)
def not_found(e):
    return jsonify({
        "error": "Endpoint not found",
        "available_endpoints": [
            "/",
            "/api/chat",
            "/api/chat?stream=true",
            "/api/info",
            "/api/models",
            "/health",
            "/v1/chat/completions",
            "/chat/completions"
        ]
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
