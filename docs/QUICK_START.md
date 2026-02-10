# 🚀 Ascende.ai Quick Start

## ✅ Setup Complete!

The agent extension has been successfully installed!

## Starting Ascende

You need **TWO terminals** running:

### Terminal 1: Watch Mode (Auto-compile)
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
npm run watch
```
**Keep this running** - it watches for code changes and auto-compiles.

### Terminal 2: Run Ascende
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
./scripts/code.sh
```
This launches the Ascende IDE with the agent now installed.

---

## What You Should See

When Ascende opens:
✅ The agent panel should be visible in the sidebar
✅ You can interact with the AI coding agent
✅ No more "command not found" errors

## If the Agent Doesn't Appear

1. Look for the agent icon in the sidebar (left side)
2. Try: **View** → **Command Palette** (Cmd+Shift+P) → Search for "Roo" or "Agent"
3. Reload the window: **Cmd+Shift+P** → "Reload Window"

## Making Changes

### To the IDE Code:
- Edit files in `ascende-lde/src/`
- Terminal 1 will auto-compile
- Reload the IDE window (Cmd+R)

### To the Agent:
- Edit files in `ascende-agent/src/`
- Rebuild: `cd ascende-agent && npm run build`
- Reinstall: `cd ascende-lde && ./scripts/code-cli.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix`
- Reload the IDE window

---

**Your Technical Co-Founder** 🚀

P.S. See `ASCENDE_SETUP_GUIDE.md` for detailed documentation.
