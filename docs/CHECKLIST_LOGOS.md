# ✅ Checklist - Substituição de Logos e Ícones

Use este checklist para garantir que todos os logos foram corretamente substituídos e testados.

## 📋 Pré-requisitos

- [ ] Assets da Ascende.ai disponíveis em `/public/`
- [ ] Workspace configurado corretamente
- [ ] Node.js e npm instalados

## 🎨 Substituição de Assets

### Ascende Agent

- [x] `assets/icons/icon.png` → Logo preto Ascende
- [x] `assets/icons/icon.svg` → Logo SVG Ascende  
- [x] `assets/icons/pear.png` → Logo app (package.json)
- [x] `assets/icons/panel_light.png` → Logo branco (tema claro)
- [x] `assets/icons/panel_dark.png` → Logo preto (tema escuro)
- [x] `assets/icons/pearai-agent-splash.png` → Splash screen
- [x] `assets/images/roo-logo.svg` → Logo SVG principal
- [x] `webview-ui/public/favicon.png` → Favicon
- [x] `webview-ui/index.html` → Título atualizado

### Ascende Extensions

- [x] `media/icon.png` → Logo app
- [x] `media/sidebar-icon.png` → Ícone sidebar
- [x] `media/PearAIImage.png` → Imagem principal
- [x] `gui/logos/pearai.png` → Logo preto GUI
- [x] `gui/logos/pearai-color.png` → Logo branco GUI
- [x] `gui/logos/creator-default.svg` → Logo SVG creator

### Assets Centralizados

- [x] Criar pasta `/assets/icons/`
- [x] Criar pasta `/assets/logos/`
- [x] Copiar todos os SVGs para `/assets/icons/`
- [x] Copiar todos os PNGs para `/assets/logos/`

## 📝 Documentação

- [x] `ASSETS_MAP.md` - Mapa de localização dos assets
- [x] `LOGO_REPLACEMENT_SUMMARY.md` - Resumo da substituição
- [x] `.github/BRANDING.md` - Guia de identidade visual
- [x] `scripts/update-logos.sh` - Script de atualização
- [x] `scripts/README.md` - Documentação de scripts
- [x] Este checklist

## 🔨 Build e Compilação

### Ascende Agent

- [x] Limpar build anterior:
  ```bash
  cd ascende-agent
  npm run clean
  ```

- [x] Instalar dependências (se necessário):
  ```bash
  npm install
  ```

- [x] Build completo:
  ```bash
  npm run build
  ```

- [x] Pacote VSIX criado:
  ```bash
  npm run vsix
  ```
  ✅ **Arquivo criado**: `bin/pearai-roo-cline-3.15.3.vsix` (16.91 MB)

### Ascende Extensions

- [ ] Limpar build anterior:
  ```bash
  cd ascende-extensions
  npm run clean
  ```

- [ ] Build:
  ```bash
  npm run build
  ```

## ✨ Testes Visuais

### Tema Claro

- [ ] Logo aparece corretamente na sidebar
- [ ] Ícone visível no painel
- [ ] Favicon carregado no navegador
- [ ] Logo legível em fundos claros
- [ ] Sem bordas ou artefatos visuais

### Tema Escuro

- [ ] Logo branco visível em fundos escuros
- [ ] Contraste adequado
- [ ] Splash screen com logo branco
- [ ] Ícones claros na interface dark

### Múltiplos Contextos

- [ ] Editor de código
- [ ] Painel lateral (sidebar)
- [ ] Barra de atividades
- [ ] Splash screen (ao carregar)
- [ ] Favicon no navegador
- [ ] Popup/dialogs
- [ ] Status bar (se aplicável)

## 🖥️ Testes Funcionais

- [ ] Extensão carrega sem erros
- [ ] Logs do console sem warnings sobre assets
- [ ] Hot reload funciona (modo dev)
- [ ] Cache limpo (Ctrl+Shift+P → "Reload Window")
- [ ] Assets carregam rapidamente

## 📱 Responsividade

- [ ] Logo escala corretamente em diferentes tamanhos
- [ ] SVGs renderizam perfeitamente
- [ ] PNGs não ficam pixelados
- [ ] Ícones mantêm proporções

## 🔍 Verificações Técnicas

### Arquivos

- [ ] Nenhum arquivo PearAI/Roo original remanescente
- [ ] Tamanhos de arquivo razoáveis (não muito grandes)
- [ ] Formato correto (PNG com transparência, SVG otimizado)
- [ ] Nomes de arquivo consistentes

### Código

- [ ] Referências no package.json corretas
- [ ] Paths de assets funcionando
- [ ] Imports de imagens sem erro
- [ ] HTML atualizado (títulos, meta tags)

### Git

- [ ] Assets adicionados ao git (se aplicável)
- [ ] .gitignore não está bloqueando assets
- [ ] Commit com mensagem descritiva

## 🚀 Deployment (quando aplicável)

- [ ] Build de produção testado
- [ ] VSIX package criado sem erros
- [ ] Instalação do .vsix funciona
- [ ] Assets incluídos no package

## 📊 Validação Final

- [ ] Todos os itens acima verificados
- [ ] Screenshots capturadas (antes/depois)
- [ ] Documentação revisada
- [ ] Equipe notificada das mudanças
- [ ] Backup dos assets originais (se necessário)

## ⚠️ Problemas Comuns

Se encontrar problemas:

### Logos não aparecem

1. Limpe o cache: Ctrl+Shift+P → "Reload Window"
2. Rebuild o projeto: `npm run build`
3. Verifique os paths no package.json
4. Confirme que os arquivos existem nos locais corretos

### Logos pixelados

1. Use SVG quando possível
2. Certifique-se de ter PNGs em alta resolução
3. Verifique se há redimensionamento excessivo

### Build falha

1. Limpe: `npm run clean`
2. Reinstale: `npm install`
3. Verifique erros de sintaxe nos arquivos modificados
4. Consulte os logs de erro

## 📞 Suporte

- **Documentação**: `ASSETS_MAP.md`, `LOGO_REPLACEMENT_SUMMARY.md`
- **Scripts**: `scripts/update-logos.sh`
- **Branding**: `.github/BRANDING.md`

---

**Data**: 9 de Fevereiro de 2026  
**Status**: ✅ Assets Substituídos | ✅ Agent Build Completo | ✅ Links Integrados  
**Próximo**: Build do Ascende LDE e testes visuais no IDE
