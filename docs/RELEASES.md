# Releases and the one-command trial

**Pilot release 0.26.1 · Fictional data only · Not a certified tax or accounting system.**

GitHub Releases on this repository publish the small files the guided trial uses. There is **no application source** in these assets.

| Asset | Purpose |
|---|---|
| `get.sh` | Installer for **Mac and Linux**. Short, readable, and it only writes under `~/.zyvor-retail`. |
| `get.ps1` | Installer for **Windows** (PowerShell; runs Retail in WSL 2). Not yet verified on a real Windows PC. |
| `zyvor-retail-install.tar.gz` | Compose file and `install.sh` that `get.sh` downloads. |
| `SHA256SUMS` | Checksums. `get.sh` refuses to run on a mismatch. |

The container image is `ghcr.io/zyvorai/zyvor-retail-site:<version>` (public pull for the trial).

## Commands

```bash
curl -fsSL https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.sh | sh -s -- up --demo
```

```powershell
& ([scriptblock]::Create((irm https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.ps1))) up --demo
```

Read the installer first if you like: download `get.sh`, open it, then run `sh get.sh up --demo`.

Guided steps: [Try it](https://zyvorai.github.io/zyvor-retail-site/try/).

## 0.26.1

Smooth Windows desktop install (NSIS Start Menu, WebView2 embed, first-run password card) and clearer one-command trial (step progress, printed admin password). Lab install smoke documents credentials in `LOGIN.txt`. Builds on 0.26.0. Schema **21**. **294** automated tests in the private source tree.

## 0.26.0

Native desktop shell (Tauri + sidecar; unsigned MSI/NSIS/DMG/AppImage packaging scripts), deeper India GST worksheets (debit notes, advances, CMP-08, GSTR-9, portal 2A JSON — not live GSTN filing), CSV/Excel migration import for products, customers, suppliers, and opening stock. Schema **21**. **294** automated tests in the private source tree.

## 0.25.0

Invoice text paste → draft PO, local product photos, park sale with optional stock hold, per-supplier lead days in Suggestions, copy-only supplier reorder message. Schema **20**.
