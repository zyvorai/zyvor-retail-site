# Getting started

**Pilot release 0.25.0 · Fictional data only · Not a certified tax or accounting system.**

Three ways to try Zyvor Retail: a one-command install on your computer, a live demo in the browser, or a source ZIP for evaluators.

## 1. Try it on your computer (recommended)

One command, about five minutes, Mac / Windows / Linux. Nothing leaves your machine. Guided steps with pictures: **[Try it](https://zyvorai.github.io/zyvor-retail-site/try/)**.

**Mac / Linux** — open Terminal, paste:

```bash
curl -fsSL https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.sh | sh -s -- up --demo
```

**Windows** — open PowerShell, paste (runs inside WSL 2; not yet verified on a real PC):

```powershell
& ([scriptblock]::Create((irm https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.ps1))) up --demo
```

The installer prints an email and password, opens `http://127.0.0.1:8080`, and seeds a fictional catalogue. Afterwards:

```bash
~/.zyvor-retail/zyvor-retail test        # expect "all checks passed"
~/.zyvor-retail/zyvor-retail uninstall   # remove containers and data
```

Release assets and checksums: [Releases](RELEASES.md).

### Read the installer first

```bash
curl -fsSL https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.sh -o get.sh
less get.sh
sh get.sh up --demo
```

## 2. The live demo (no install)

A running copy with a fictional store. Open it from the [website](https://zyvorai.github.io/zyvor-retail-site/#demo).

| | |
|---|---|
| **Storefront** (no login needed) | Browse, search, add to the bag and send a pickup request. Nothing is charged online. |
| **Staff console** (login on request) | [Request a demo login](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20demo%20login&body=Hi%2C%20please%20send%20me%20the%20demo%20login%20for%20Zyvor%20Retail.%0A%0AName%3A%0ACompany%3A). |
| **Please note** | Shared fictional data only. Not for real customer data. |

### Sixty seconds: what to click

1. **Read the overview.** See what needs attention, ranked.
2. **Sell something.** Open your shift, press `/`, type a product, Enter, enter cash for change due.
3. **Dig into stock.** Products → sort a column → open a row for batches.

Press `?` for shortcuts. `Cmd+K` finds anything.

## 3. Source ZIP (evaluators)

The application source is private. [Ask for access](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot); you receive a ZIP. You need **Python 3.12+ with SQLite**. Unpack it, then:

```bash
export RETAIL_ADMIN_EMAIL=owner@zyvor.local
read -s -p 'Initial admin password (12+ characters): ' RETAIL_ADMIN_PASSWORD; printf '\n'
export RETAIL_ADMIN_PASSWORD
python3 -m retail.server --demo
```

**Choose your own password and never commit it.**

## Pilot it safely

Treat Zyvor Retail as a **pilot**. The core trading, stock, tax-invoice and ledger flows work and are tested, but certified GST filing, payment gateways and hardware drivers are not there. Run it **alongside your existing process** first. See [Intended use and limits](INTENDED-USE.md).

## Tell us how it went

[sales@zyvor.dev](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20feedback), or a **Feedback** issue here (never include customer data, passwords or payment details).
