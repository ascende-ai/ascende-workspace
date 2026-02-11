# Mapa de Assets da Ascende.ai

Este documento mapeia onde os logos e ícones da Ascende.ai estão localizados nos diferentes projetos.

## Assets Originais

Localização: `/public/`

### Estrutura de Pastas:
```
/public
├── ascende-logo/           # Logos com fundo
│   ├── 12.png
│   ├── 13.png
│   ├── 14.png
│   ├── 16.png
│   ├── 17.png
│   └── icon-app.png       # Logo principal para ícone de app
│
├── ascende-logo-transparente/  # Logos com fundo transparente
│   ├── 14.png
│   ├── 15.png
│   ├── ascendeai-branco.png   # Logo branco (para fundos escuros)
│   ├── ascendeai-preto.png    # Logo preto (para fundos claros)
│   ├── logo-branco.png
│   └── logo-preto.png
│
└── ascende-svg/            # Versões vetoriais (SVG)
    ├── 12.svg
    ├── 13.svg
    ├── 14.svg
    ├── 15.svg
    ├── 16.svg
    └── 17.svg
```

## Assets Centralizados

Localização: `/assets/`

```
/assets
├── logos/                  # Todos os PNGs (com e sem fundo)
└── icons/                  # Todos os SVGs vetoriais
```

## Mapeamento por Projeto

### 1. Ascende Agent (ascende-agent/)

**Localização dos Assets**: `ascende-agent/assets/`

| Arquivo Original | Novo Asset | Uso |
|-----------------|------------|-----|
| `assets/icons/icon.png` | `ascendeai-preto.png` | Ícone principal do editor |
| `assets/icons/icon.svg` | `12.svg` | Versão vetorial do ícone |
| `assets/icons/pear.png` | `icon-app.png` | Ícone do painel (package.json) |
| `assets/icons/panel_light.png` | `logo-branco.png` | Painel modo claro |
| `assets/icons/panel_dark.png` | `logo-preto.png` | Painel modo escuro |
| `assets/icons/pearai-agent-splash.png` | `ascendeai-branco.png` | Splash screen |
| `assets/images/roo-logo.svg` | `12.svg` | Logo SVG principal |

**Referências no código**:
- `package.json` (linha 6): `"icon": "assets/icons/pear.png"`
- `package.json` (linha 69): Container view icon

### 2. Ascende Extensions (ascende-extensions/)

**Localização dos Assets**: `ascende-extensions/extensions/vscode/`

| Arquivo Original | Novo Asset | Uso |
|-----------------|------------|-----|
| `media/icon.png` | `icon-app.png` | Ícone da extensão |
| `media/sidebar-icon.png` | `icon-app.png` | Ícone da sidebar |
| `media/PearAIImage.png` | `ascendeai-preto.png` | Imagem principal |
| `gui/logos/pearai.png` | `ascendeai-preto.png` | Logo no GUI (preto) |
| `gui/logos/pearai-color.png` | `ascendeai-branco.png` | Logo no GUI (branco) |
| `gui/logos/creator-default.svg` | `12.svg` | Logo SVG padrão |

**Referências no código**:
- `package.json` (linha 5): `"icon": "media/icon.png"`
- `package.json` (linha 659, 664, 669): Sidebar icons

### 3. Ascende LDE (ascende-lde/)

O projeto ascende-lde é uma versão customizada do VS Code e contém muitas extensões internas. Os logos principais do VSCode não foram modificados para manter a compatibilidade.

**Extensões que podem usar logos personalizados**:
- `extensions/vscode-test-resolver/media/icon.png`
- `extensions/vscode-colorize-tests/media/icon.png`
- `extensions/vscode-api-tests/media/icon.png`

_Nota: Essas são extensões de teste/desenvolvimento e podem não precisar dos logos da Ascende.ai_

## Guia de Uso

### Quando usar cada versão:

1. **Logo Preto (`ascendeai-preto.png`)**: 
   - Fundos claros
   - Tema light do editor
   - Documentação impressa

2. **Logo Branco (`ascendeai-branco.png`)**:
   - Fundos escuros
   - Tema dark do editor
   - Splash screens

3. **SVG (`12.svg`, etc.)**:
   - Quando precisar de escalabilidade
   - Ícones de interface
   - Logos responsivos

4. **Icon App (`icon-app.png`)**:
   - Ícone principal da aplicação
   - Favicon
   - Ícone do sistema operacional

## Atualização dos Assets

Para atualizar os assets em todos os projetos:

```bash
# A partir da raiz do workspace
cd /Users/emcasa/Documents/ascende-workspace

# Ascende Agent
cp public/ascende-logo/icon-app.png ascende-agent/assets/icons/pear.png
cp public/ascende-logo-transparente/ascendeai-preto.png ascende-agent/assets/icons/icon.png
cp public/ascende-svg/12.svg ascende-agent/assets/icons/icon.svg

# Ascende Extensions
cp public/ascende-logo/icon-app.png ascende-extensions/extensions/vscode/media/icon.png
cp public/ascende-logo-transparente/ascendeai-preto.png ascende-extensions/extensions/vscode/media/PearAIImage.png
cp public/ascende-svg/12.svg ascende-extensions/extensions/vscode/gui/logos/creator-default.svg
```

## Status da Substituição

- [x] Ascende Agent - Logos substituídos
- [x] Ascende Extensions - Logos substituídos  
- [x] Assets centralizados organizados
- [ ] Ascende LDE - Avaliar necessidade (extensões de teste)

## Notas Técnicas

1. **Formato dos Arquivos**:
   - PNGs devem ter fundo transparente quando aplicável
   - SVGs devem ser otimizados e sem dependências externas
   - Tamanhos recomendados: 128x128px, 256x256px, 512x512px

2. **Compatibilidade**:
   - Todos os logos foram substituídos mantendo os nomes originais dos arquivos
   - As referências no package.json não precisam ser alteradas
   - O rebuild/recompile pode ser necessário para que as mudanças sejam refletidas

3. **Próximos Passos**:
   - Rebuild do Ascende Agent: `cd ascende-agent && npm run build`
   - Rebuild do Ascende Extensions: `cd ascende-extensions && npm run build`
   - Testar os logos nos temas claro e escuro
   - Verificar se os favicons foram atualizados

---

**Última atualização**: 9 de Fevereiro de 2026
**Responsável**: Ascende.ai Team
