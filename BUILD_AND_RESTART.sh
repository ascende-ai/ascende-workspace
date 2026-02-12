#!/bin/bash

set -e

echo "🔨 Building ascende-agent..."
cd ascende-agent
npm run build
cd ..

echo "🔨 Building ascende-extensions..."
cd ascende-extensions/extensions/vscode
npm run esbuild
cd ../../..

echo "✅ Build completed!"
echo ""
echo "🔄 Restarting Ascende..."
./RESTART_ASCENDE.sh
