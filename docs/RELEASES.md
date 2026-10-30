# Releases and the one-command trial

**Pilot release 0.22.0 · Fictional data only · Not a certified tax or accounting system.**

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
