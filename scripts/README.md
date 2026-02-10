# Scripts - Ascende.ai

Este diretório contém scripts úteis para manutenção do workspace.

## Scripts Disponíveis

### `update-logos.sh`

Atualiza todos os logos e ícones da Ascende.ai nos projetos.

**Uso**:
```bash
cd /Users/emcasa/Documents/ascende-workspace
./scripts/update-logos.sh
```

**O que faz**:
1. Copia logos de `/public/` para `ascende-agent/assets/`
2. Atualiza ícones em `ascende-extensions/extensions/vscode/`
3. Organiza assets centralizados em `/assets/`
4. Fornece feedback visual do processo

**Quando usar**:
- Após receber novos assets da equipe de design
- Ao atualizar a identidade visual
- Para garantir consistência após modificações

## Estrutura de Pastas

```
scripts/
├── README.md           # Este arquivo
└── update-logos.sh     # Script de atualização de logos
```

## Adicionando Novos Scripts

Ao adicionar um novo script:

1. Coloque o arquivo neste diretório
2. Torne-o executável: `chmod +x scripts/seu-script.sh`
3. Documente aqui no README.md
4. Adicione comentários no código
5. Use feedback visual (cores, emojis) para melhor UX

## Convenções

- Use `#!/bin/bash` no início
- Inclua `set -e` para exit on error
- Adicione cabeçalho com autor e data
- Use variáveis para paths importantes
- Forneça feedback claro ao usuário
- Documente todas as dependências

## Suporte

Para dúvidas ou problemas com os scripts:
- Consulte `ASSETS_MAP.md` para mapeamento de assets
- Veja `LOGO_REPLACEMENT_SUMMARY.md` para histórico
- Entre em contato com a equipe de desenvolvimento

---

**Última atualização**: 9 de Fevereiro de 2026
