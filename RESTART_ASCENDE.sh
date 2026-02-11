#!/bin/bash

# Restart Ascende app to load new extensions
echo "🔄 Restarting Ascende..."

# Kill the current Ascende process
pkill -f "ascende.ai.app/Contents/MacOS/Electron" || pkill -f "PearAI.app/Contents/MacOS/Electron"
sleep 2

# Navigate to ascende-lde
cd "$(dirname "$0")/ascende-lde"

# Restart the app
echo "🚀 Launching Ascende..."
./scripts/code.sh
