# 🚀 Ascende.ai Complete Setup Guide

## Architecture Overview

Your Ascende.ai system consists of three main components that work together:

```
┌─────────────────────────────────────────────────────────────┐
│                     ASCENDE ECOSYSTEM                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. ascende-lde (Main IDE Application)                      │
│     └─ Fork of VSCode/PearAI                                │
│     └─ The desktop application you see and interact with    │
│     └─ Status: ✅ Compiled and Running                      │
│                                                              │
│  2. ascende-agent (AI Coding Agent Extension)               │
│     └─ Fork of Roo Code/Cline                               │
│     └─ Built as .vsix extension                             │
│     └─ Installed INTO ascende-lde                           │
│     └─ Provides the AI agent functionality                  │
│     └─ Status: ✅ Built and Installed                       │
│                                                              │
│  3. ascende-extensions (GUI & Extensions)                   │
│     └─ Additional extensions and GUI components             │
│     └─ Optional - only needed for GUI development           │
│     └─ Status: 📦 Available for future development          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Current Project Status (Updated: Feb 09, 2026)

### ✅ What's Working
- **IDE Compilation**: ascende-lde is fully compiled and running
- **Watch Mode**: Auto-recompilation is active in Terminal 1
- **Agent Extension**: pearai-roo-cline-3.15.3.vsix built successfully
- **Extension Installed**: Agent is installed in `~/.pearai-dev/extensions/`
- **IDE Running**: Application launches and displays

### ⚠️ Current Issues
1. **Branding**: Still using PearAI references (needs Ascende branding)
2. **API Key**: "PearAI API key not found" - needs configuration
3. **Extension Dependencies**: Some PearAI-specific dependencies need updating

### 🎯 Next Steps
1. **Branding Update**: Replace PearAI references with Ascende branding
2. **API Configuration**: Set up API keys for AI models
3. **Extension Customization**: Modify agent for Ascende-specific features
4. **Testing**: Verify all functionality works with custom branding

## Complete Setup Process

### Step 1: Build the Agent Extension ✅ COMPLETED

```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
npm run install:all
npm run build
```

**Result**: Created `bin/pearai-roo-cline-3.15.3.vsix`

### Step 2: Setup the IDE ✅ COMPLETED

```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
npm install
npm run compile
```

**Result**: IDE fully compiled in `out/` directory

### Step 3: Install the Agent Extension ✅ COMPLETED

```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
```

**Result**: Extension installed in `~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/`

### Step 4: Start Ascende Development Environment ✅ RUNNING

You need TWO terminals running:

#### Terminal 1: Watch Mode ✅ ACTIVE
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
npm run watch
```
**Current Status**: 
- ✅ Running since 16:50:51
- ✅ Auto-recompiling on file changes
- ✅ Both client and extensions watching
- **Keep this running in the background**

**What this does**: 
- Watches for code changes
- Auto-recompiles when you edit files
- Runs two parallel watchers:
  - `watch-client`: IDE core compilation
  - `watch-extensions`: Built-in extensions compilation

#### Terminal 2: Run the Application ✅ EXECUTED
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
./scripts/code.sh
```
**Current Status**:
- ✅ Application launched successfully
- ✅ Agent extension loaded
- ⚠️ Showing "PearAI extension not found" warning (expected, needs branding update)
- ⚠️ Missing API key configuration

**What this does**: 
- Launches the Ascende IDE in development mode
- Loads the installed agent extension
- Opens with debugger on port 5870

### Step 5 (Optional): GUI Development

Only if you're editing the GUI/webviews:

#### Terminal 3: GUI Dev Server
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
npm run dev
```
**What this does**: 
- Starts Vite dev server for agent GUI
- Enables hot-reload for React components
- Only needed if editing the agent's interface

## Verification Checklist

Current status of the application:

### ✅ Working Correctly
- [x] Ascende IDE opens without crashes
- [x] Agent panel is visible in the sidebar (pearai-roo-cline)
- [x] Extension host running (pid visible in logs)
- [x] Webview loads successfully
- [x] Watch mode auto-compiling changes
- [x] No fatal errors or crashes

### ⚠️ Current Warnings (Safe to Ignore)
- API proposal deprecation warnings (normal in development)
- PostHog telemetry warnings (analytics not configured)
- MCP Hub 404 errors (optional backend service)
- CORS errors for chat.json (external Microsoft service)
- "Installation has been modified on disk" (expected in dev mode)
- ExplorerView errors (non-critical UI issue)

### 🔧 Issues Requiring Attention
- [x] "PearAI extension not found" - Extension expects PearAI main extension
- [x] "PearAI API key not found" - API configuration needed
- [ ] Branding still shows PearAI references
- [ ] Color theme loading errors (undefined properties)
- [ ] Custom modes JSON parsing error (empty file)

### 📝 Files Needing Configuration
- `~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/.env` (missing)
- `~/Library/Application Support/code-oss-dev/User/globalStorage/pearai.pearai-roo-cline/settings/custom_modes.json` (malformed)

## Quick Start Script

For daily development, use this workflow:

```bash
# Terminal 1: Start watch mode (keep running)
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde && npm run watch

# Terminal 2: Launch the app (in a new terminal)
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde && ./scripts/code.sh
```

## Troubleshooting Guide

### Common Issues & Solutions

#### 1. "PearAI extension not found"
**Symptom**: Error message in Extension Host logs  
**Cause**: Agent expects a main PearAI extension to be present  
**Status**: ⚠️ Expected until branding is updated  
**Solution**:
```typescript
// Update ascende-agent/src/core/agent.ts (or similar)
// Remove or comment out PearAI extension check
// Or update to look for ascende.core extension
```

#### 2. "PearAI API key not found"
**Symptom**: Agent can't connect to AI models  
**Cause**: Missing API configuration  
**Solution**:
```bash
# Create .env file in extension directory
cat > ~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/.env << EOF
ANTHROPIC_API_KEY=your_key_here
OPENAI_API_KEY=your_key_here
EOF
```

#### 3. Custom Modes JSON Error
**Symptom**: "Unexpected end of JSON input" in custom_modes.json  
**Cause**: Empty or malformed JSON file  
**Solution**:
```bash
# Fix the JSON file
mkdir -p ~/Library/Application\ Support/code-oss-dev/User/globalStorage/pearai.pearai-roo-cline/settings/
echo '[]' > ~/Library/Application\ Support/code-oss-dev/User/globalStorage/pearai.pearai-roo-cline/settings/custom_modes.json
```

#### 4. Extension Not Loading
**Symptom**: Agent panel doesn't appear  
**Diagnosis**:
```bash
# Check if extension is installed
ls -la ~/.pearai-dev/extensions/ | grep roo-cline

# Check extension host output
# In IDE: View → Output → Select "Extension Host"
```
**Solution**:
```bash
cd ascende-lde
./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
```

#### 5. Compilation Errors
**Symptom**: Watch mode shows errors  
**Diagnosis**: Check Terminal 1 output  
**Solution**:
```bash
# Stop watch mode (Ctrl+C in Terminal 1)
cd ascende-lde
rm -rf out/
npm run compile
npm run watch
```

#### 6. IDE Won't Start
**Symptom**: Application crashes on launch  
**Diagnosis**:
```bash
# Check if out/ directory exists and has files
cd ascende-lde
ls -la out/
```
**Solution**:
```bash
# Recompile from scratch
npm run compile
# Wait for completion (~1-2 minutes)
./scripts/code.sh
```

#### 7. Hot Reload Not Working
**Symptom**: GUI changes don't appear  
**Cause**: Dev server not running or wrong port  
**Solution**:
```bash
# Start dev server
cd ascende-agent
npm run dev

# If port 5174 is busy, kill process
lsof -ti:5174 | xargs kill -9
npm run dev
```

#### 8. Extension Host Crashes
**Symptom**: Extension stops working, needs reload  
**Cause**: Memory leak or unhandled error  
**Solution**:
1. Open Developer Tools: `Cmd+Shift+P` → "Developer: Toggle Developer Tools"
2. Check Console for errors
3. Reload Window: `Cmd+R`
4. If persistent, restart IDE completely

### Clean Rebuild (Nuclear Option)

If everything is broken and nothing works:

```bash
# 1. Kill all processes
pkill -f "code-oss-dev"
pkill -f "electron"

# 2. Clean IDE
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
rm -rf out/ node_modules/
npm install
npm run compile

# 3. Clean Agent
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
rm -rf bin/ dist/ node_modules/
npm run install:all
npm run build

# 4. Clean user data (CAUTION: loses settings)
# rm -rf ~/Library/Application\ Support/code-oss-dev/
# rm -rf ~/.pearai-dev/

# 5. Reinstall agent
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix

# 6. Start fresh
npm run watch &
sleep 5
./scripts/code.sh
```

### Debugging Tips

#### View Logs
```bash
# IDE logs
tail -f ~/Library/Logs/code-oss-dev/

# Extension logs (in IDE)
# View → Output → Select source:
# - Extension Host
# - Log (Extension Host)
# - PearAI Roo Code / Cline
```

#### Enable Verbose Logging
```bash
# Launch with verbose logging
cd ascende-lde
./scripts/code.sh --verbose --log trace
```

#### Inspect Extension
```bash
# View installed extension files
cd ~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/
ls -la

# Check extension size (should be ~10-20MB)
du -sh .
```

#### Performance Issues
```bash
# Monitor compilation time
cd ascende-lde
time npm run compile

# Check memory usage during watch
ps aux | grep node
```

## File Locations & Structure

### Important Paths

#### Source Code
- **IDE Core**: `/Users/emcasa/Documents/ascende-workspace/ascende-lde/src/`
  - TypeScript files for VSCode core
  - ~5,125 .ts files
  - ~273 CSS files
- **Agent Source**: `/Users/emcasa/Documents/ascende-workspace/ascende-agent/src/`
  - ~586 .ts files
  - ~179 .tsx files (React components)
- **Agent Webview**: `/Users/emcasa/Documents/ascende-workspace/ascende-agent/webview-ui/`
  - React/Vite application
  - UI components for agent interface

#### Build Outputs
- **IDE Compiled**: `/Users/emcasa/Documents/ascende-workspace/ascende-lde/out/`
  - JavaScript output from TypeScript compilation
  - Generated automatically by watch mode
- **Agent VSIX**: `/Users/emcasa/Documents/ascende-workspace/ascende-agent/bin/pearai-roo-cline-3.15.3.vsix`
  - Packaged extension file
  - Ready for installation

#### Runtime Locations
- **Installed Extension**: `~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/`
  - Where the IDE loads the extension from
  - Includes dist/ folder with bundled code
- **User Data**: `~/Library/Application Support/code-oss-dev/`
  - Settings, preferences, global storage
  - Extension data and configurations
- **Workspace Storage**: Per-project extension data

### Configuration Files

#### IDE Configuration
- **Product**: `ascende-lde/product.json`
  - Product ID, name, branding
  - Extension APIs enabled
  - Marketplace settings
- **Package**: `ascende-lde/package.json`
  - Name: "pearai" (version 1.96.4)
  - Dependencies and scripts
  - Build configuration
- **TypeScript**: `ascende-lde/tsconfig.json`
  - TypeScript compiler settings
- **Launch**: `ascende-lde/scripts/code.sh`
  - Development launch script
  - Sets environment variables

#### Agent Configuration  
- **Package**: `ascende-agent/package.json`
  - Name: "pearai-roo-cline" (version 3.15.3)
  - Extension metadata
  - Commands, menus, keybindings
- **Build**: `ascende-agent/esbuild.js`
  - Extension bundling configuration
- **Webview**: `ascende-agent/webview-ui/package.json`
  - React app dependencies
  - Vite configuration

#### Environment Files (Need Creation)
- `ascende-agent/.env` (missing)
- Extension `.env` at `~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/.env` (missing)
- Custom modes JSON (malformed, needs fix)

### Technology Stack

#### IDE (ascende-lde)
- **Base**: VSCode 1.96.4 / PearAI fork
- **Language**: TypeScript 5.8.0
- **Framework**: Electron 32.2.6
- **Build**: Gulp, esbuild, webpack
- **Node**: 20.x

#### Agent (ascende-agent)
- **Language**: TypeScript 5.4.5
- **UI Framework**: React (in webview)
- **Build**: esbuild, Vite
- **AI SDKs**: 
  - Anthropic SDK
  - OpenAI SDK
  - Google GenAI
  - AWS Bedrock
  - Mistral AI
- **MCP**: Model Context Protocol SDK
- **Testing**: Jest, Playwright

#### Key Dependencies
- Monaco Editor (code editor)
- xterm.js (terminal)
- tree-sitter (syntax parsing)
- ripgrep (code search)

## Development Workflow

### Making Changes to the IDE
**When**: Modifying core IDE functionality, UI, or built-in features

1. Edit files in `ascende-lde/src/`
2. Terminal 1 (`npm run watch`) will auto-compile (already running)
3. Wait for compilation to complete (watch terminal output)
4. Reload the IDE window:
   - Quick: `Cmd+R` (macOS)
   - Menu: `Cmd+Shift+P` → "Developer: Reload Window"
5. Check Terminal 1 for any compilation errors

**Common Files**:
- `src/vs/workbench/browser/`: Main workbench UI
- `src/vs/platform/`: Platform services
- `product.json`: Product configuration and branding

### Making Changes to the Agent Extension
**When**: Modifying AI agent logic, commands, or core functionality

1. Edit files in `ascende-agent/src/`
2. Rebuild the extension:
   ```bash
   cd ascende-agent
   npm run build
   ```
3. Reinstall in the IDE:
   ```bash
   cd ../ascende-lde
   ./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
   ```
4. Reload the IDE window (Cmd+R)

**Build Time**: ~30-60 seconds for full rebuild

**Common Files**:
- `src/extension.ts`: Extension entry point
- `src/api/`: API providers and integrations
- `src/core/`: Core agent functionality
- `package.json`: Extension metadata

### Making Changes to Agent GUI (Hot Reload) 🔥
**When**: Modifying the agent's React interface/UI

#### Terminal 3: GUI Dev Server
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
npm run dev
```

**What this enables**:
- Instant hot-reload of React components
- Fast iteration on UI changes
- Live preview at `http://localhost:5174`
- No rebuild or reinstall needed

**Workflow**:
1. Start dev server (Terminal 3)
2. Edit files in `ascende-agent/webview-ui/src/`
3. Changes appear instantly in the IDE
4. When satisfied, run full build to package

**Common Files**:
- `webview-ui/src/components/`: React components
- `webview-ui/src/App.tsx`: Main app component
- `webview-ui/src/styles/`: CSS styles

### Quick Commands Reference

```bash
# Terminal 1 (Keep Running)
cd ascende-lde && npm run watch

# Terminal 2 (When needed)
cd ascende-lde && ./scripts/code.sh

# Terminal 3 (Optional, for GUI dev)
cd ascende-agent && npm run dev

# Rebuild agent after changes
cd ascende-agent && npm run build

# Reinstall agent
cd ascende-lde && ./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
```

## Next Steps - Customization Roadmap

### Phase 1: Branding & Identity 🎨
**Priority: HIGH - Required for MVP**

1. **Update Extension Branding**
   - [ ] Change extension ID from `pearai.pearai-roo-cline` to `ascende.ascende-agent`
   - [ ] Update display name to "Ascende Agent"
   - [ ] Replace logo/icon files in `ascende-agent/assets/icons/`
   - [ ] Update package.json publisher field
   - [ ] Rebuild and reinstall extension

2. **Update IDE Branding**
   - [ ] Change product name in `ascende-lde/product.json`
   - [ ] Update application icons
   - [ ] Customize splash screen
   - [ ] Update window title
   - [ ] Change application ID

3. **Remove PearAI Dependencies**
   - [ ] Update extension activation code (remove PearAI extension check)
   - [ ] Replace API endpoints
   - [ ] Update authentication flow
   - [ ] Remove PearAI-specific telemetry

### Phase 2: Configuration & Setup 🔧
**Priority: HIGH - Needed for functionality**

1. **API Configuration**
   - [ ] Create `.env` file in extension directory
   - [ ] Configure AI model API keys (Anthropic/OpenAI/etc)
   - [ ] Set up custom API endpoints if needed
   - [ ] Configure rate limiting and quotas

2. **Settings & Preferences**
   - [ ] Fix custom_modes.json parsing
   - [ ] Configure default models
   - [ ] Set up allowed commands list
   - [ ] Configure storage paths

3. **Extension Configuration**
   - [ ] Update MCP server settings
   - [ ] Configure terminal integration
   - [ ] Set up code context defaults
   - [ ] Configure webview settings

### Phase 3: Features & Functionality 🚀
**Priority: MEDIUM - Enhancement phase**

1. **Agent Capabilities**
   - [ ] Test and verify code generation
   - [ ] Test file operations
   - [ ] Test terminal command execution
   - [ ] Test multi-file editing

2. **IDE Integration**
   - [ ] Verify syntax highlighting
   - [ ] Test debugging features
   - [ ] Check extension compatibility
   - [ ] Test workspace features

3. **Performance Optimization**
   - [ ] Monitor compilation times
   - [ ] Optimize extension size
   - [ ] Improve startup time
   - [ ] Reduce memory usage

### Phase 4: Testing & Quality 🧪
**Priority: MEDIUM - Before production**

1. **Functional Testing**
   - [ ] Create test workspace
   - [ ] Test common workflows
   - [ ] Test error handling
   - [ ] Test edge cases

2. **User Experience**
   - [ ] Polish UI/UX
   - [ ] Improve error messages
   - [ ] Add helpful tooltips
   - [ ] Create onboarding flow

3. **Documentation**
   - [ ] User manual
   - [ ] Developer guide
   - [ ] API documentation
   - [ ] Troubleshooting guide

### Phase 5: Distribution 📦
**Priority: LOW - Future considerations**

1. **Packaging**
   - [ ] Create installers (macOS/Windows/Linux)
   - [ ] Sign applications
   - [ ] Create update mechanism
   - [ ] Prepare marketplace submission

2. **Deployment**
   - [ ] Set up update server
   - [ ] Configure telemetry
   - [ ] Set up crash reporting
   - [ ] Prepare marketing materials

## Current Development Status

### What's Working ✅
1. **Build System**: All compilation and bundling works correctly
2. **Development Environment**: Watch mode and hot reload functional
3. **Extension Loading**: Agent extension loads and activates
4. **Core IDE**: Main application launches and runs stable
5. **Terminal Integration**: Terminal commands and output work
6. **File Operations**: Can read/write files through IDE
7. **WebView**: Agent UI renders and displays correctly

### What Needs Work 🔧
1. **Branding**: Still references PearAI throughout
   - Extension ID
   - Display names
   - Icons and logos
   - About dialogs
2. **API Configuration**: Keys need to be set up
   - Create .env files
   - Configure model endpoints
   - Set up authentication
3. **Dependencies**: Remove PearAI-specific checks
   - Extension activation logic
   - API endpoints
   - Telemetry services

### Immediate Next Steps (This Week)

#### Day 1-2: Environment Setup
- [ ] Create proper .env files
- [ ] Fix custom_modes.json
- [ ] Test AI model connectivity
- [ ] Verify basic agent functionality

#### Day 3-4: Branding Phase 1
- [ ] Update extension package.json
- [ ] Replace logo files
- [ ] Update display names
- [ ] Change extension ID

#### Day 5-7: Code Updates
- [ ] Remove PearAI extension checks
- [ ] Update API endpoints
- [ ] Test and verify functionality
- [ ] Fix any breaking changes

### Testing Checklist

Before moving to production:
- [ ] Can create new files
- [ ] Can edit existing files
- [ ] Can execute terminal commands
- [ ] Can generate code with AI
- [ ] Can navigate workspace
- [ ] Can use keyboard shortcuts
- [ ] Extension persists across restarts
- [ ] Settings save correctly
- [ ] No memory leaks during use
- [ ] Handles errors gracefully

## Support & Resources

### Documentation Created
- `ASCENDE_SETUP_GUIDE.md` (this file) - Complete setup and development guide
- `QUICK_START.md` - Quick reference for daily development
- `START_DEV.md` - Original migration notes

### Backup Locations
- **Original PearAI**: `/Users/emcasa/Documents/pearai-master`
- **Full Backup**: `/Users/emcasa/Documents/pearai-master-backup-20260209_163030`
- **Migration Date**: February 09, 2026

### Project Statistics
- **IDE Files**: 7,787 files (5,125 .ts, 935 .json)
- **Agent Files**: 1,182 files (586 .ts, 179 .tsx)
- **Extensions**: 1,184 files
- **Total LOC**: ~500,000+ lines
- **Node Version**: 20.18.1
- **TypeScript**: 5.8.0 (IDE), 5.4.5 (Agent)

### Quick Reference Card

```bash
# Start Development (2 terminals)
Terminal 1: cd ascende-lde && npm run watch
Terminal 2: cd ascende-lde && ./scripts/code.sh

# Optional GUI dev
Terminal 3: cd ascende-agent && npm run dev

# Rebuild & Reinstall Agent
cd ascende-agent && npm run build
cd ../ascende-lde && ./scripts/code.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix

# Reload IDE
Cmd+R (macOS) or Cmd+Shift+P → "Reload Window"

# View Logs
View → Output → Select "Extension Host"

# Check Status
ps aux | grep electron  # IDE running
ps aux | grep node      # Watch mode active
```

### Useful Commands

```bash
# Check if everything is compiled
ls -la ascende-lde/out/
ls -la ascende-agent/bin/

# See installed extensions
ls -la ~/.pearai-dev/extensions/

# Monitor watch mode
tail -f ascende-lde/out/vs/workbench/workbench.desktop.main.js

# Kill stuck processes
pkill -f code-oss-dev
pkill -f electron

# Disk space check
du -sh ascende-workspace/
```

### Contact & Collaboration

This is a **Technical Co-Founder** project - we're building a real, production-ready IDE.

**Philosophy**:
- Move fast but maintain quality
- Test everything before committing
- Document as we build
- Keep user in control

**Communication**:
- Ask questions when unclear
- Propose solutions with trade-offs
- Push back on bad ideas
- Celebrate milestones

---

## 🚀 Ready to Build

Your Ascende development environment is **SET UP and RUNNING**!

Current status: ✅ **DEVELOPMENT READY**

Watch mode is active, IDE is running, agent is installed. Time to customize and make it yours!

**Your Technical Co-Founder** 🎯
