# Ascende.ai Development Environment - Guia de Inicialização

## Correções Críticas Aplicadas

### 1. Corrigido Erro "Extension Not Found" ✅
- **Arquivo**: `ascende-lde/product.json`
- **Problema**: Referência à extensão antiga `pearai.pearai` não existente
- **Correção**: Atualizado para `PearAI.pearai-roo-cline` (o agente instalado)

### 2. Extensão Principal PearAI Instalada ✅
- **Componente**: `ascende-extensions/extensions/vscode` → `pearai.pearai v2.0.0`
- **Problema**: Extensão core que fornece Chat, Search e Memories não estava instalada
- **Correção**: Construída e instalada como `pearai-2.0.0.vsix`

### 3. Corrigido Erro de TypeScript no ModelSelect ✅
- **Arquivo**: `ascende-extensions/gui/src/components/modelSelection/ModelSelect.tsx`
- **Problema**: Variável `themeType` não definida no componente `ModelOption`
- **Correção**: Adicionado `const themeType = useThemeType();`

---

## Como Iniciar o Ambiente de Desenvolvimento Ascende.ai

### Pré-requisitos
- Node.js 20.18.0 (já configurado)
- Todas as dependências instaladas (veja seção de setup se necessário)

### Inicialização Passo a Passo

#### Terminal 1: Watch & Compilar Ascende IDE
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
npm run watch
```
**O que isso faz**: 
- Monitora mudanças no código principal do IDE
- Compila TypeScript continuamente
- Recompila automaticamente quando você edita arquivos
- **Mantenha esse terminal rodando**

#### Terminal 2: Iniciar a Aplicação Ascende
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
./scripts/code.sh
```
**O que isso faz**: 
- Inicia a aplicação Electron do Ascende IDE
- Usa o código compilado do Terminal 1
- Carrega automaticamente ambas as extensões instaladas
- **Inicie isso DEPOIS que o Terminal 1 estiver watching**

#### Terminal 3 (Opcional): GUI Dev Server do Agent
Se você estiver editando a interface do agente:
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
npm run dev
```
**O que isso faz**: 
- Inicia servidor Vite dev na porta `5174`
- Habilita hot-reload para componentes da UI do agente
- **Apenas necessário se estiver editando código da GUI do agente**

---

## Verificação de Funcionamento

Após iniciar, verifique estes indicadores:

### ✅ Sinais Positivos
- Ambas as extensões aparecem nos logs: `pearai.pearai` e `PearAI.pearai-roo-cline`
- Painel do agente visível na barra lateral direita
- Ícones de Chat, Search e Memories clicáveis no topo do painel
- Log mostra: `"Models successfully loaded from server"`
- Sem erros de "extension not found"

### ⚠️ Avisos Esperados (Pode Ignorar)
- Avisos de API proposals (apenas avisos de deprecação)
- Erros 404 do MCP server (serviços cloud opcionais)
- "Failed to fetch servers to remove" (não crítico)
- Erros de tema de cor (não afeta funcionalidade)
- CORS errors para Azure CDN (chat registry - não crítico)
- Warnings sobre logo ascendeai-branco.png (apenas visual)

### ❌ Problemas para Observar
- Se webviews mostrarem em branco → Verifique se extensões foram carregadas
- Se ícones de Chat/Search/Memories não funcionarem → Verifique logs de extensão
- Se app crashar imediatamente → Verifique erros de compilação no Terminal 1

---

## Arquitetura do Projeto

### Componentes Principais

#### 1. `ascende-lde/` - IDE Principal
- Fork do VSCode/PearAI
- Contém o core da aplicação Electron
- Gerencia extensões e interface principal

#### 2. `ascende-agent/` - Agente de Código
- Fork do Roo Code/Cline
- Extensão empacotada como `.vsix`
- Fornece funcionalidade de agente autônomo
- **Instalado em**: `~/.pearai-dev/extensions/pearai.pearai-roo-cline-3.15.3/`

#### 3. `ascende-extensions/` - Extensões AI
- Fork do Continue (PearAI submodule)
- Fornece Chat, Search, Memories e recursos AI
- GUI construída com React + Vite
- **Instalado em**: `~/.pearai-dev/extensions/pearai.pearai-2.0.0/`

---

## Troubleshooting

### IDE Não Inicia
1. Certifique-se que Terminal 1 (`npm run watch`) completou compilação inicial
2. Verifique erros no output do Terminal 1
3. Tente: `cd ascende-lde && npm run compile` (build completo one-time)

### Extensões Não Carregam
1. Verifique que ambas as extensões estão instaladas:
   ```bash
   ls -la ~/.pearai-dev/extensions/
   ```
   Deve mostrar:
   - `pearai.pearai-2.0.0/`
   - `pearai.pearai-roo-cline-3.15.3/`

2. Se alguma estiver faltando, reinstale:
   ```bash
   # Agent
   cd ascende-lde
   ./scripts/code-cli.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
   
   # PearAI Core
   ./scripts/code-cli.sh --install-extension ../ascende-extensions/extensions/vscode/build/pearai-2.0.0.vsix
   ```

### Chat/Search/Memories Não Funcionam
1. Certifique-se que a extensão `pearai.pearai` está instalada (veja acima)
2. Verifique logs no Terminal 2 para erros de "PearAI extension not found"
3. Se aparecer esse erro, reinstale a extensão core (comando acima)

### Precisa Reconstruir Extensões

#### Reconstruir Agent:
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
npm run install:all
npm run build
# Reinstalar: veja comando acima
```

#### Reconstruir PearAI Core Extension:
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-extensions
./scripts/install-and-build.sh
# Reinstalar: veja comando acima
```

### Limpar e Reconstruir Tudo
Se tudo estiver quebrado:
```bash
# Limpar e reconstruir IDE
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
rm -rf out/
npm run compile

# Depois reinicie os terminais 1 e 2
```

---

## Referência Rápida

### Workflow Mais Comum
Para desenvolvimento típico (editando código core do IDE):
1. `cd ascende-lde && npm run watch` (manter rodando)
2. `cd ascende-lde && ./scripts/code.sh` (em novo terminal)
3. Faça mudanças → Hot-reload automático

### Desenvolvimento Full Stack
Para mudanças no IDE + Agent GUI:
1. Terminal 1: `cd ascende-lde && npm run watch`
2. Terminal 2: `cd ascende-agent && npm run dev`  
3. Terminal 3: `cd ascende-lde && ./scripts/code.sh`

### Desenvolvimento de Extensões
Para editar Chat/Search/Memories:
1. Terminal 1: `cd ascende-lde && npm run watch`
2. Terminal 2: `cd ascende-extensions/gui && npm run dev`
3. Terminal 3: `cd ascende-lde && ./scripts/code.sh`
4. Após mudanças: reconstruir com `./scripts/install-and-build.sh`

---

## Setup Inicial (Se Necessário)

Se você está começando do zero ou precisa reinstalar dependências:

### 1. Instalar Dependências do IDE
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-lde
npm install
npm run compile
```

### 2. Construir e Instalar Agent
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-agent
npm run install:all
npm run build

# Instalar no IDE
cd ../ascende-lde
./scripts/code-cli.sh --install-extension ../ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
```

### 3. Construir e Instalar PearAI Extension
```bash
cd /Users/emcasa/Documents/ascende-workspace/ascende-extensions
./scripts/install-and-build.sh

# Instalar no IDE
cd ../ascende-lde
./scripts/code-cli.sh --install-extension ../ascende-extensions/extensions/vscode/build/pearai-2.0.0.vsix
```

---

## Estrutura de Diretórios

```
ascende-workspace/
├── ascende-lde/              # IDE principal (VSCode fork)
│   ├── out/                  # Código compilado
│   ├── scripts/
│   │   ├── code.sh          # Inicia o IDE
│   │   └── code-cli.sh      # CLI para instalar extensões
│   └── product.json          # Configuração de produto
│
├── ascende-agent/            # Agente de código (Roo Code fork)
│   ├── webview-ui/          # Interface React
│   ├── bin/                 # .vsix compilado
│   └── package.json
│
├── ascende-extensions/       # Extensões AI (Continue fork)
│   ├── core/                # Lógica core
│   ├── gui/                 # Interface React
│   ├── extensions/vscode/   # Extensão VSCode
│   │   └── build/          # .vsix compilado
│   └── scripts/
│       └── install-and-build.sh
│
└── Documentos/
    ├── START_DEV.md         # Este arquivo
    ├── EXTENSIONS_FIXED.md  # Log de correções
    ├── MIGRATION_COMPLETE.md
    └── ASCENDE_SETUP_GUIDE.md
```

---

## O Que Estava Errado?

### Antes das Correções:
❌ Painel do agente visível mas não funcional  
❌ Ícones de Chat/Search/Memories não clicáveis  
❌ Erro: "PearAI extension not found"  
❌ Erro: "command 'pearai.chatView.focus' not found"  
❌ Referência incorreta em `product.json`  

### Depois das Correções:
✅ Ambas as extensões instaladas e funcionais  
✅ Chat, Search e Memories acessíveis  
✅ Models carregados com sucesso  
✅ Agente totalmente operacional  
✅ `product.json` com referências corretas  

---

## Recursos do Agente

Quando tudo estiver funcionando, você terá acesso a:

### 🤖 Painel do Agente (Barra Lateral Direita)
- Chat interface principal
- Campo de input para tarefas
- Configurações de auto-approve

### 🔍 Funcionalidades Disponíveis
- **Chat**: Interface de conversação com IA
- **Search**: Busca semântica no código
- **Memories**: Gerenciamento de contexto e memória
- **Context**: Menções de arquivos com @file
- **Inline Edit**: Cmd+I / Ctrl+I
- **Code Selection**: Cmd+L / Ctrl+L
- **Tab Autocomplete**: Sugestões automáticas

---

**Última Atualização**: 9 de Fevereiro, 2026  
**Seu Co-Founder Técnico** 🚀
