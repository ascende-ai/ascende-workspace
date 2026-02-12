# Como Compilar e Atualizar o Ascende

## Estrutura do Projeto

O projeto Ascende é composto por vários submodules:

- **ascende-lde**: Fork do VSCode/Cursor (a IDE principal)
- **ascende-agent**: Agente de código autônomo (fork do Roo Code/Cline)
- **ascende-extensions**: Extensões do Continue (chat, search, memories)
- **eigent-backend**: Backend Python

## Extensões Built-in

As extensões são carregadas automaticamente pelo `ascende-lde` através de links simbólicos:

```
ascende-lde/extensions/
├── PearAI-Roo-Code -> ../../ascende-agent
└── pearai-submodule -> ../../ascende-extensions/extensions/vscode
```

## Como Compilar e Reiniciar

### Opção 1: Script Automático (Recomendado)

```bash
./BUILD_AND_RESTART.sh
```

Este script:
1. Compila o `ascende-agent`
2. Compila o `ascende-extensions`
3. Reinicia o Ascende

### Opção 2: Manual

```bash
# 1. Compilar ascende-agent
cd ascende-agent
npm run build
cd ..

# 2. Compilar ascende-extensions
cd ascende-extensions/extensions/vscode
npm run build
cd ../../..

# 3. Reiniciar Ascende
./RESTART_ASCENDE.sh
```

## Mudanças Recentes

### Rebranding para "ascende.ai Agent"

Todas as referências a "Powered by Roo Code / Cline" foram removidas:

- ✅ Arquivos i18n (16 idiomas)
- ✅ `modes.ts` e testes
- ✅ `package.json` (displayName e publisher)
- ✅ `Features.tsx` e `InventoryPage.tsx`
- ✅ `product.json` (publisher atualizado para `ascendeai`)

### Publisher

O publisher foi alterado de `PearAI` para `ascendeai` para seguir as regras do VSCode Marketplace (não permite pontos no nome).

## Verificação

Após compilar e reiniciar, verifique se:

1. O chat mostra "ascende.ai Agent" (sem "Powered by...")
2. O code agent mostra "ascende.ai Agent"
3. Não há erros no console de desenvolvimento

## Troubleshooting

### "command not found: code"

Isso é normal no Cursor. Use o script `BUILD_AND_RESTART.sh` ao invés de tentar instalar manualmente.

### Mudanças não aparecem

1. Certifique-se de ter compilado ambas as extensões
2. Reinicie o Ascende completamente (não apenas reload)
3. Verifique se os links simbólicos estão corretos:
   ```bash
   ls -la ascende-lde/extensions/
   ```

### Erros de "tree-sitter.wasm" ou "llamaTokenizerWorkerPool.mjs"

Esses erros são relacionados ao `ascende-extensions` e não afetam o funcionamento do `ascende-agent`. Para corrigi-los, você precisaria compilar completamente o `ascende-extensions` com todos os seus assets.

## Status das Mudanças

✅ **Concluído:**
- Rebranding completo para "ascende.ai Agent"
- Remoção de todas as referências a "Powered by Roo Code / Cline"
- Atualização de 16 idiomas (i18n)
- Link simbólico criado no `ascende-lde`
- Publisher atualizado para `ascendeai`
- Script de build automático criado

🔍 **Para verificar:**
Abra o Ascende e verifique se:
1. O chat mostra "ascende.ai Agent" sem "Powered by..."
2. O code agent mostra "ascende.ai Agent"
3. A página de boas-vindas mostra o nome correto
