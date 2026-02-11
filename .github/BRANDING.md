# Guia de Branding - Ascende.ai

## 🎨 Identidade Visual

Este documento define as diretrizes de uso dos logos e ícones da Ascende.ai.

## Logos Disponíveis

### 1. Logo Principal

**Arquivo**: `ascendeai-preto.png` / `ascendeai-branco.png`

- **Uso**: Logo completo com nome "Ascende AI"
- **Formato**: PNG com transparência
- **Tamanhos**: Múltiplos tamanhos disponíveis
- **Contexto**:
  - Preto: Fundos claros, documentação, interfaces light
  - Branco: Fundos escuros, splash screens, interfaces dark

### 2. Ícone da Aplicação

**Arquivo**: `icon-app.png`

- **Uso**: Ícone principal da aplicação
- **Formato**: PNG
- **Contexto**: Favicon, ícone do sistema, marketplace

### 3. Logos Vetoriais

**Arquivos**: `12.svg`, `13.svg`, `14.svg`, `15.svg`, `16.svg`, `17.svg`

- **Uso**: Interface, escalabilidade infinita
- **Formato**: SVG otimizado
- **Contexto**: UI components, ícones responsivos

## Estrutura de Arquivos

```
/public/
├── ascende-logo/              # PNGs com fundo
│   └── icon-app.png          # → Ícone principal
│
├── ascende-logo-transparente/ # PNGs transparentes
│   ├── ascendeai-branco.png  # → Tema dark
│   ├── ascendeai-preto.png   # → Tema light
│   ├── logo-branco.png       # → Painel dark
│   └── logo-preto.png        # → Painel light
│
└── ascende-svg/               # Vetoriais
    └── *.svg                 # → Interface escalável

/assets/                       # Assets centralizados
├── icons/                    # Todos os SVGs
└── logos/                    # Todos os PNGs
```

## Regras de Uso

### ✅ Permitido

- Usar os logos nos produtos oficiais da Ascende.ai
- Redimensionar mantendo proporções
- Usar versão adequada ao tema (claro/escuro)
- Aplicar em fundos sólidos apropriados

### ❌ Não Permitido

- Modificar cores ou proporções
- Adicionar efeitos, sombras ou distorções
- Usar em fundos que comprometam legibilidade
- Combinar com outras marcas sem autorização

## Cores da Marca

As cores exatas devem ser extraídas dos logos originais:

- **Primária**: [A definir com base no logo]
- **Secundária**: [A definir com base no logo]
- **Tema Dark**: Fundo escuro com logo branco
- **Tema Light**: Fundo claro com logo preto

## Espaçamento

Manter sempre um espaço mínimo ao redor do logo equivalente a:
- 20% da altura do logo em todos os lados
- Nunca encostar em bordas ou outros elementos

## Tamanhos Mínimos

Para garantir legibilidade:
- **Digital**: Mínimo 32x32px
- **Impressão**: Mínimo 1cm de altura
- **Favicon**: 16x16px, 32x32px, 64x64px

## Aplicações por Contexto

### Web/Digital
- Favicon: `icon-app.png` (múltiplos tamanhos)
- Header: `ascendeai-preto.png` ou `ascendeai-branco.png`
- Footer: `logo-preto.png` ou `logo-branco.png`
- UI Icons: `*.svg` (vetorial)

### IDE/Editor
- Sidebar: `icon-app.png`
- Panel Icons: `panel_light.png` / `panel_dark.png`
- Splash Screen: `ascendeai-branco.png`
- Activity Bar: `icon.svg`

### Documentação
- Markdown: `![Ascende.ai](assets/logos/ascendeai-preto.png)`
- README: Logo preto em fundo branco
- Dark Mode: Logo branco em fundo escuro

### Marketing
- Apresentações: Alta resolução, logo completo
- Redes Sociais: Versão adequada ao contexto
- Print: Vetorial quando possível (SVG convertido)

## Atualizações

Para atualizar os logos em todo o projeto:

1. Substitua os arquivos em `/public/`
2. Execute o script de atualização (se disponível)
3. Ou siga o guia em `ASSETS_MAP.md`

## Contato

Para dúvidas sobre uso da marca:
- Email: [branding@ascende.ai]
- Documentação: `ASSETS_MAP.md`

---

**Versão**: 1.0  
**Última Atualização**: 9 de Fevereiro de 2026  
**Mantido por**: Ascende.ai Team
