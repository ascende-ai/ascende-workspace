# PDF Viewer - Built-in Extension ✅

## Quick Summary

The PDF viewer extension is installed **directly in the Ascende app** as a built-in extension.

**Location:** `ascende-lde/extensions/pdf-viewer/`

## How to Use

1. **Restart Ascende** (if not already restarted):
   ```bash
   ./RESTART_ASCENDE.sh
   ```

2. **Open any PDF file** in the Ascende app
   - It will now render properly with a PDF viewer
   - No more binary text garbage!

3. **Features available:**
   - Page-by-page rendering
   - Zoom controls (fit-to-width, fit-to-page, custom %)
   - Page thumbnails sidebar
   - Search within PDF
   - Download/print options

## Technical Details

- **Extension ID:** `tomoki1207.pdf`
- **Type:** Built-in (part of Ascende app)
- **Size:** ~16MB (includes PDF.js library)
- **Activation:** Automatic when `.pdf` files are opened

## Why Built-in?

PDFs are critical for Ascende's workflow:
- Legal documents
- Reports and analytics  
- Research papers
- Data sheets
- Contracts

Having the PDF viewer as a **built-in extension** means:
- ✅ Always available in the app
- ✅ No separate installation needed
- ✅ Works for all users of your Ascende build
- ✅ Part of the product, not a development tool

## Files

```
ascende-lde/extensions/pdf-viewer/
├── out/src/extension.js  ← Entry point
├── lib/                  ← PDF.js library (16MB)
├── package.json
└── src/                  ← TypeScript source
```

## Restart Script

Use the provided restart script:
```bash
./RESTART_ASCENDE.sh
```

This will:
1. Kill the current Ascende process
2. Wait 2 seconds
3. Relaunch Ascende from `ascende-lde/`

---

**Status:** ✅ Installed - Ready after restart  
**Date:** February 9, 2026
