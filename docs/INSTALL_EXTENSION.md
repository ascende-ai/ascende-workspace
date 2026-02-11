# Como Instalar a Extensão Ascende Agent

## ✅ Método Recomendado: Via Interface do Cursor

### Passo a Passo:

1. **Abra o Cursor** (já está aberto)

2. **Pressione**: `Cmd + Shift + P` (ou `⌘ + ⇧ + P`)

3. **Digite**: `Extensions: Install from VSIX`

4. **Navegue até**: 
   ```
   /Users/emcasa/Documents/ascende-workspace/ascende-agent/bin/
   ```

5. **Selecione**: `pearai-roo-cline-3.15.3.vsix`

6. **Clique em**: "Install"

7. **Recarregue**: Quando solicitado, clique em "Reload Window" ou pressione `Cmd + R`

---

## 🔧 Método Alternativo: Adicionar comando cursor ao PATH

Se quiser usar linha de comando no futuro:

1. **Abra o Cursor**

2. **Pressione**: `Cmd + Shift + P`

3. **Digite**: `Shell Command: Install 'cursor' command in PATH`

4. **Clique**: No comando que aparecer

Depois disso, você poderá usar:
```bash
cursor --install-extension bin/pearai-roo-cline-3.15.3.vsix
```

---

## 🚀 Método Alternativo 2: Arrastar e Soltar

1. **Abra o Cursor**

2. **Abra a aba Extensions** (ícone de quadrados na barra lateral ou `Cmd + Shift + X`)

3. **No Finder**, navegue até:
   ```
   /Users/emcasa/Documents/ascende-workspace/ascende-agent/bin/
   ```

4. **Arraste** o arquivo `pearai-roo-cline-3.15.3.vsix` para a janela de Extensions

5. **Confirme** a instalação

---

## ✨ Após Instalar

1. **Procure o ícone** da Ascende Agent na barra lateral de atividades
2. **Clique nele** para abrir o painel
3. **Verifique** se o logo da Ascende.ai aparece corretamente
4. **Teste** em tema claro e escuro:
   - Tema claro: `Cmd + K, Cmd + T` → Escolha "Light+"
   - Tema escuro: `Cmd + K, Cmd + T` → Escolha "Dark+"

---

## 🐛 Resolução de Problemas

### Se a extensão não aparecer:

1. **Recarregue a janela**: `Cmd + R` ou `Cmd + Shift + P` → "Reload Window"

2. **Desinstale versões antigas**:
   - Vá em Extensions
   - Procure por "PearAI" ou "Roo Cline"
   - Desinstale versões antigas
   - Reinstale a nova versão

3. **Verifique logs**:
   - `Cmd + Shift + U` → Selecione "Extension Host"
   - Procure por erros

### Se os logos não aparecerem:

1. **Force reload**: `Cmd + Option + R` (pode ser necessário reabrir o Cursor)

2. **Limpe cache**:
   ```bash
   rm -rf ~/.cursor/extensions/pearai.*
   ```
   Depois reinstale a extensão

---

## 📍 Localização do Arquivo

O arquivo VSIX está em:
```
/Users/emcasa/Documents/ascende-workspace/ascende-agent/bin/pearai-roo-cline-3.15.3.vsix
```

Tamanho: **16.91 MB**

---

**Use o Método Recomendado (Via Interface) para instalar agora! 🚀**
