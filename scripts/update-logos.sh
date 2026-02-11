#!/bin/bash

# Script para atualizar logos e ícones da Ascende.ai em todos os projetos
# Autor: Ascende.ai Team
# Data: 9 de Fevereiro de 2026

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🎨 Atualizando logos e ícones da Ascende.ai..."
echo "📁 Workspace: $WORKSPACE_ROOT"
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para copiar com feedback
copy_asset() {
    local source=$1
    local dest=$2
    local description=$3
    
    if [ -f "$WORKSPACE_ROOT/$source" ]; then
        cp "$WORKSPACE_ROOT/$source" "$WORKSPACE_ROOT/$dest"
        echo -e "${GREEN}✓${NC} $description"
    else
        echo -e "⚠️  Source not found: $source"
    fi
}

echo -e "${BLUE}1. Atualizando Ascende Agent...${NC}"

# Ascende Agent - Icons
copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-agent/assets/icons/icon.png" "Icon principal"
copy_asset "public/ascende-svg/12.svg" "ascende-agent/assets/icons/icon.svg" "Icon SVG"
copy_asset "public/ascende-logo/icon-app.png" "ascende-agent/assets/icons/pear.png" "Icon app (package.json)"
copy_asset "public/ascende-logo-transparente/logo-branco.png" "ascende-agent/assets/icons/panel_light.png" "Panel light"
copy_asset "public/ascende-logo-transparente/logo-preto.png" "ascende-agent/assets/icons/panel_dark.png" "Panel dark"
copy_asset "public/ascende-logo-transparente/ascendeai-branco.png" "ascende-agent/assets/icons/pearai-agent-splash.png" "Splash screen"

# Ascende Agent - Images
copy_asset "public/ascende-svg/12.svg" "ascende-agent/assets/images/roo-logo.svg" "Roo logo SVG"

# Ascende Agent - Webview
copy_asset "public/ascende-logo/icon-app.png" "ascende-agent/webview-ui/public/favicon.png" "Favicon webview"

echo ""
echo -e "${BLUE}2. Atualizando Ascende Extensions...${NC}"

# Ascende Extensions - Media
copy_asset "public/ascende-logo/icon-app.png" "ascende-extensions/extensions/vscode/media/icon.png" "Icon extension"
copy_asset "public/ascende-logo/icon-app.png" "ascende-extensions/extensions/vscode/media/sidebar-icon.png" "Sidebar icon"
copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-extensions/extensions/vscode/media/PearAIImage.png" "PearAI Image"

# Ascende Extensions - GUI Logos
copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-extensions/extensions/vscode/gui/logos/pearai.png" "GUI logo preto (pearai.png)"
copy_asset "public/ascende-logo-transparente/ascendeai-branco.png" "ascende-extensions/extensions/vscode/gui/logos/pearai-color.png" "GUI logo branco (pearai-color.png)"
copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-extensions/extensions/vscode/gui/logos/ascendeai-preto.png" "GUI logo preto (ascendeai-preto.png - light theme)"
copy_asset "public/ascende-logo-transparente/ascendeai-branco.png" "ascende-extensions/extensions/vscode/gui/logos/ascendeai-branco.png" "GUI logo branco (ascendeai-branco.png - dark theme)"
copy_asset "public/ascende-svg/12.svg" "ascende-extensions/extensions/vscode/gui/logos/creator-default.svg" "Creator logo SVG"

echo ""
echo -e "${BLUE}2b. Atualizando Ascende LDE (pearai-submodule)...${NC}"
if [ -d "$WORKSPACE_ROOT/ascende-lde/extensions/pearai-submodule/gui/logos" ]; then
    copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-lde/extensions/pearai-submodule/gui/logos/pearai.png" "pearai-submodule logo preto"
    copy_asset "public/ascende-logo-transparente/ascendeai-branco.png" "ascende-lde/extensions/pearai-submodule/gui/logos/pearai-color.png" "pearai-submodule logo branco"
else
    echo -e "⚠️  pearai-submodule gui/logos not found, skipping"
fi

echo ""
echo -e "${BLUE}3. Organizando assets centralizados...${NC}"

# Criar diretórios se não existirem
mkdir -p "$WORKSPACE_ROOT/assets/icons"
mkdir -p "$WORKSPACE_ROOT/assets/logos"

# Copiar para assets centralizados
if [ -d "$WORKSPACE_ROOT/public/ascende-logo" ]; then
    cp -r "$WORKSPACE_ROOT/public/ascende-logo/"* "$WORKSPACE_ROOT/assets/logos/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Logos copiados para /assets/logos"
fi

if [ -d "$WORKSPACE_ROOT/public/ascende-logo-transparente" ]; then
    cp -r "$WORKSPACE_ROOT/public/ascende-logo-transparente/"* "$WORKSPACE_ROOT/assets/logos/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Logos transparentes copiados"
fi

if [ -d "$WORKSPACE_ROOT/public/ascende-svg" ]; then
    cp -r "$WORKSPACE_ROOT/public/ascende-svg/"* "$WORKSPACE_ROOT/assets/icons/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} SVGs copiados para /assets/icons"
fi

echo ""
echo -e "${BLUE}4. Atualizando Ascende LDE (VS Code Core)...${NC}"

# LDE Welcome Screen Logo
copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-lde/src/vs/workbench/contrib/welcomeGettingStarted/common/media/pearai-explain-codebase.png" "Welcome screen logo"
if [ -f "$WORKSPACE_ROOT/ascende-lde/out/vs/workbench/contrib/welcomeGettingStarted/common/media/pearai-explain-codebase.png" ]; then
    copy_asset "public/ascende-logo-transparente/ascendeai-preto.png" "ascende-lde/out/vs/workbench/contrib/welcomeGettingStarted/common/media/pearai-explain-codebase.png" "Welcome screen logo (compiled)"
fi

echo ""
echo -e "${GREEN}✅ Logos e ícones atualizados com sucesso!${NC}"
echo ""
echo "📋 Próximos passos:"
echo "1. Rebuild Ascende Agent: cd ascende-agent && npm run build"
echo "2. Rebuild Ascende Extensions: cd ascende-extensions && npm run build"
echo "3. Teste visual nos temas claro e escuro"
echo ""
echo "📖 Documentação: ASSETS_MAP.md e LOGO_REPLACEMENT_SUMMARY.md"
