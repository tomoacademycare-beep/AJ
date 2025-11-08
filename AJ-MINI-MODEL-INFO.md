# AJ-Mini Model Information

## 📊 Technical Specifications

### Base Model Architecture
- **Architecture**: Qwen2 (from Alibaba's Qwen family)
- **Parameters**: 1.8 Billion (1.8B)
- **Quantization**: Q4_K_M (4-bit medium quality quantization)
- **Model Size**: ~1.2 GB on disk
- **Memory Usage**: 2-3 GB RAM during inference

### Context & Capabilities
- **Maximum Context Length**: 131,072 tokens
- **Active Context Window**: 4,096 tokens
- **Embedding Dimensions**: 1,536
- **Capabilities**: Completion, Thinking mode (chain-of-thought reasoning)

### Model Parameters
- **Temperature**: 0.3 (focused and consistent responses)
- **Top-P**: 0.95 (nucleus sampling)
- **Top-K**: 40 (token selection diversity)
- **Repeat Penalty**: 1.1 (reduces repetition)

## 🏢 Model Identity

### Current Configuration
- **Name**: AJ-Mini
- **Version**: v2.0
- **Creator**: AJ STUDIOZ
- **Website**: https://ajstudioz.co.in
- **Purpose**: Fast, efficient AI assistance with enterprise reliability

## 🔧 What Was Updated

### Enhanced System Prompt Features:
1. **Stronger Identity**: Emphasizes "AJ-Mini" name and AJ STUDIOZ as creator
2. **Technical Transparency**: Includes detailed model specifications in the prompt
3. **Professional Personality**: Balanced, efficient, and intelligent responses
4. **Clear Capabilities**: Highlights coding, writing, analysis, and business support
5. **Brand Representation**: Every response reflects AJ STUDIOZ values

### Key Improvements:
- ✅ Model explicitly identifies as "AJ-Mini" (not just "AJ")
- ✅ Credits AJ STUDIOZ as creator in every introduction
- ✅ Includes full technical specs (Qwen2, 1.8B params, 1.2GB size)
- ✅ Enhanced personality: efficient yet powerful
- ✅ Better structured response format
- ✅ Improved safety and ethical guidelines
- ✅ API integration support

## 📝 Model Introduction Template

When asked "Who are you?", AJ-Mini now responds:

> "I'm **AJ-Mini**, a compact AI assistant created by **AJ STUDIOZ**. I'm built on the Qwen2 architecture with 1.8B parameters (about 1.2GB in size), designed to deliver fast, intelligent, and helpful responses. Despite my smaller size, I'm optimized for professional use with strong reasoning capabilities, code generation, and thoughtful assistance. I'm powered by AJ STUDIOZ's commitment to efficient, ethical, and excellent AI. How can I help you today?"

## 🚀 How to Use

### Run the model:
```powershell
ollama run aj-mini
```

### Check model info:
```powershell
ollama show aj-mini
```

### View full modelfile:
```powershell
ollama show aj-mini --modelfile
```

### Update the model (using the Modelfile):
```powershell
ollama create aj-mini -f Modelfile-aj-mini-v2
```

## 💡 Key Strengths

1. **Compact but Powerful**: Only 1.2GB but delivers quality responses
2. **Fast Inference**: Optimized Qwen2 architecture for quick responses
3. **Smart Reasoning**: Built-in thinking mode for complex problems
4. **Professional Quality**: Enterprise-grade assistance
5. **Efficient**: Low memory footprint, high performance

## 📄 Files Created

- `Modelfile-aj-mini-v2` - Enhanced model configuration
- `AJ-MINI-MODEL-INFO.md` - This documentation file

## 🔄 Update History

- **v2.0** (Current): Enhanced identity, technical transparency, improved personality
- **v1.0** (Previous): Basic AJ assistant configuration

---

**Built with care by AJ STUDIOZ | Powered by Qwen2 | Optimized for Excellence**
