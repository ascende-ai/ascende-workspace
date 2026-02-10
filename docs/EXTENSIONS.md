# Ascende Workspace Extensions

## Overview

This workspace includes bundled extensions that are automatically loaded when you open the project. These extensions are essential for Ascende's workflow and don't require separate installation.

## 📦 Bundled Extensions

### PDF Viewer
**Extension ID:** `tomoki1207.pdf`  
**Location:** `.vscode/extensions/tomoki1207.pdf/`  
**Status:** ✅ Built-in (always available)

**Why it's included:**
PDFs are a critical document format in Ascende. This extension provides native PDF viewing capabilities directly in your editor, eliminating the need to switch to external PDF readers.

**Features:**
- 📄 View PDF files directly in editor tabs
- 🔍 Zoom controls (fit-to-width, fit-to-page, custom zoom)
- 📑 Sidebar with page thumbnails
- 🔎 Search within PDF content
- 📖 Multiple viewing modes (vertical, horizontal, wrapped)
- 📚 Spread modes for book-style reading

**Default Configuration:**
```json
{
  "pdf-preview.default.cursor": "select",
  "pdf-preview.default.scale": "page-width",
  "pdf-preview.default.sidebar": true,
  "pdf-preview.default.scrollMode": "vertical",
  "pdf-preview.default.spreadMode": "none"
}
```

## 🚀 How It Works

1. **Automatic Loading:** Extensions in `.vscode/extensions/` are automatically discovered and loaded by VSCode/Cursor
2. **No Installation Required:** Anyone who clones this repository gets these extensions immediately
3. **Version Controlled:** The extension source code is committed to the repository
4. **Isolated:** Extension dependencies are in `.gitignore` but can be rebuilt anytime

## 🛠️ For Developers

### First Time Setup
If you just cloned the repository, the extensions are already built. If for some reason you need to rebuild:

```bash
cd .vscode/extensions/tomoki1207.pdf
npm install
npm run compile
```

### Testing the PDF Viewer
1. Open any `.pdf` file in the workspace
2. The file should open in the built-in PDF viewer
3. Use the toolbar at the top to zoom, search, and navigate

### Updating Extensions

To update the PDF viewer to the latest version:

```bash
cd .vscode/extensions/tomoki1207.pdf
git pull origin main
npm install
npm run compile
```

Then reload the window (Cmd+Shift+P → "Developer: Reload Window")

### Adding New Extensions

To add another bundled extension:

1. **Clone the extension:**
   ```bash
   cd .vscode/extensions
   git clone <extension-repo-url> <extension-name>
   ```

2. **Install and build:**
   ```bash
   cd <extension-name>
   npm install
   npm run compile  # or npm run build, depending on the extension
   ```

3. **Document it:**
   - Add it to this file
   - Add it to `.vscode/extensions.json` recommendations
   - Update `.vscode/extensions/README.md`

4. **Commit:**
   ```bash
   git add .vscode/extensions/<extension-name>
   git commit -m "Add <extension-name> bundled extension"
   ```

## 📋 Extension Checklist

When adding a new bundled extension, ensure:

- [ ] Extension source code is in `.vscode/extensions/<name>/`
- [ ] `node_modules/` is ignored by `.gitignore`
- [ ] Extension has been compiled (`out/` or `dist/` exists)
- [ ] Extension is documented in this file
- [ ] Extension is added to `.vscode/extensions.json`
- [ ] Team has been notified of the new extension

## 🔧 Troubleshooting

### Extension not loading
1. Check if it's been compiled:
   ```bash
   ls .vscode/extensions/tomoki1207.pdf/out/
   ```
2. Rebuild if needed:
   ```bash
   cd .vscode/extensions/tomoki1207.pdf && npm run compile
   ```
3. Reload window: Cmd+Shift+P → "Developer: Reload Window"

### PDF files not opening in viewer
1. Check file association in settings:
   ```json
   "files.associations": {
     "*.pdf": "pdf"
   }
   ```
2. Right-click the PDF → "Reopen With..." → "Pdf Preview"

### Extension errors in console
1. Open Extension Host Log: Cmd+Shift+P → "Developer: Show Logs" → "Extension Host"
2. Look for errors related to the extension
3. Try rebuilding the extension

## 📚 Resources

- [PDF Viewer GitHub](https://github.com/tomoki1207/vscode-pdfviewer)
- [VSCode Extension API](https://code.visualstudio.com/api)
- [Bundling Extensions Guide](https://code.visualstudio.com/api/working-with-extensions/bundling-extension)

## 🤝 Contributing

To propose a new bundled extension:

1. Create an issue explaining why the extension is critical for Ascende
2. Demonstrate that it's actively maintained
3. Verify it works with the current VSCode/Cursor version
4. Follow the "Adding New Extensions" process above
5. Submit a PR with documentation updates

---

**Last Updated:** February 9, 2026  
**Maintained by:** Ascende Team
