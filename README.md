# Ascende Workspace

Complete development workspace for the Ascende.ai project - an AI-powered code editor and development environment.

## Repository Structure

This workspace contains three main projects as Git submodules:

### 1. [ascende-lde](https://github.com/ascende-ai/ascende-lde.git) - Main IDE
- Fork of VSCode/PearAI
- The desktop application (Electron-based)
- ~7,787 files (5,125 TypeScript files)
- Version: 1.96.4

### 2. [ascende-agent](https://github.com/ascende-ai/ascende-agent.git) - AI Agent Extension
- Fork of Roo Code/Cline
- AI coding agent functionality
- ~1,182 files (586 TypeScript, 179 TSX files)
- Packaged as VSCode extension (.vsix)

### 3. [ascende-extensions](https://github.com/ascende-ai/ascende-extensions.git) - Additional Extensions
- Fork of Continue
- GUI components and extensions
- ~1,184 files

## Quick Start

See **[QUICK_START.md](QUICK_START.md)** for daily development commands.

## Complete Setup Guide

See **[ASCENDE_SETUP_GUIDE.md](ASCENDE_SETUP_GUIDE.md)** for comprehensive setup instructions.

## Development Environment

### Prerequisites
- Node.js 20.18.0+ (use nvm: `nvm use`)
- npm 10.8.2+
- Git

### Clone with Submodules

```bash
# Clone the workspace
git clone https://github.com/ascende-ai/ascende-workspace.git
cd ascende-workspace

# Initialize and clone submodules
git submodule update --init --recursive
```

### Daily Development Workflow

#### Terminal 1: IDE Watch Mode
```bash
cd ascende-lde
npm run watch
```

#### Terminal 2: Run the Application
```bash
cd ascende-lde
./scripts/code.sh
```

#### Terminal 3 (Optional): GUI Development
```bash
cd ascende-agent
npm run dev
```

## Project Status

**Status**: ✅ Development Ready

- ✅ IDE compiled and running
- ✅ Agent extension built and installed
- ✅ Watch mode active with auto-compilation
- ⚠️ Needs branding update (PearAI → Ascende)
- ⚠️ Needs API configuration

## Documentation

- **[ASCENDE_SETUP_GUIDE.md](ASCENDE_SETUP_GUIDE.md)** - Complete setup and configuration guide (795 lines)
- **[QUICK_START.md](QUICK_START.md)** - Quick reference for daily development
- **[START_DEV.md](START_DEV.md)** - Original migration and setup notes

## Architecture

```
ascende-workspace/
├── ascende-lde/           # Main IDE (VSCode fork)
│   ├── src/               # TypeScript source
│   ├── out/               # Compiled JavaScript
│   └── scripts/           # Launch scripts
├── ascende-agent/         # AI Agent Extension
│   ├── src/               # Extension source
│   ├── webview-ui/        # React UI
│   └── bin/               # Built .vsix
└── ascende-extensions/    # Additional Extensions
    ├── gui/               # GUI components
    └── core/              # Core functionality
```

## Key Features

### Current Capabilities
- ✅ Full VSCode-compatible IDE
- ✅ AI-powered code agent
- ✅ Multi-model AI support (Claude, GPT, etc)
- ✅ Terminal integration
- ✅ File operations and editing
- ✅ Code understanding and generation

### In Progress
- 🔧 Ascende branding
- 🔧 Custom AI model endpoints
- 🔧 Enhanced agent capabilities
- 🔧 Performance optimizations

## Technology Stack

### IDE (ascende-lde)
- TypeScript 5.8.0
- Electron 32.2.6
- Monaco Editor
- Node.js 20.x

### Agent (ascende-agent)
- TypeScript 5.4.5
- React (webview UI)
- Multiple AI SDKs (Anthropic, OpenAI, Google, etc)
- Model Context Protocol (MCP)

## Contributing

Each submodule has its own contribution guidelines:
- See `ascende-lde/CONTRIBUTING.md`
- See `ascende-agent/CONTRIBUTING.md`
- See `ascende-extensions/CONTRIBUTING.md`

## Building

### Build All
```bash
# Install dependencies for all projects
cd ascende-lde && npm install
cd ../ascende-agent && npm run install:all
cd ../ascende-extensions && npm install

# Compile IDE
cd ../ascende-lde && npm run compile

# Build agent extension
cd ../ascende-agent && npm run build
```

### Install Agent Extension
```bash
cd ascende-lde
./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
```

## Troubleshooting

Common issues and solutions are documented in [ASCENDE_SETUP_GUIDE.md](ASCENDE_SETUP_GUIDE.md#troubleshooting-guide).

Quick fixes:
```bash
# Reload IDE
Cmd+R (macOS) or Ctrl+R (Windows)

# Restart watch mode
cd ascende-lde
pkill -f "gulp watch"
npm run watch

# Clean rebuild
npm run compile
```

## License

- IDE: MIT License (inherited from VSCode)
- Agent: Apache 2.0 License (inherited from Roo Code/Cline)
- Extensions: Apache 2.0 License (inherited from Continue)

## Links

- **IDE Repository**: https://github.com/ascende-ai/ascende-lde
- **Agent Repository**: https://github.com/ascende-ai/ascende-agent
- **Extensions Repository**: https://github.com/ascende-ai/ascende-extensions
- **Workspace Repository**: https://github.com/ascende-ai/ascende-workspace

## Support

For setup issues or questions, refer to:
1. [ASCENDE_SETUP_GUIDE.md](ASCENDE_SETUP_GUIDE.md) - Comprehensive guide
2. [QUICK_START.md](QUICK_START.md) - Quick commands
3. GitHub Issues in respective repositories

---

**Last Updated**: February 09, 2026  
**Development Status**: ✅ Ready for Customization  
**Next Phase**: Branding Update & API Configuration
