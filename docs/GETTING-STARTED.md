# Getting started

**Pilot release 0.6.2 · Fictional data only · Not a certified tax or accounting system.**

Two ways to try Zyvor Retail: a live demo you can open now, or a copy you run yourself.

## 1. The live demo

A running copy with a fictional store: four weeks of sales, low stock, a pickup request and an expiring batch are already there, so the reorder suggestions have something to work from.

| | |
|---|---|
| **Storefront** (no login needed) | Browse the catalogue, search, add to the bag and send a pickup request, just as a shopper would. Nothing is charged online. |
| **Staff console** (login on request) | The console needs a login, so we send one on request. It is a cashier account: ring up sales, scan, look at stock, customers and orders. [Request a demo login](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20demo%20login&body=Hi%2C%20please%20send%20me%20the%20demo%20login%20for%20Zyvor%20Retail.%0A%0AName%3A%0ACompany%3A). |
| **Please note** | Every visitor shares the same data, so you may see other people's test sales. Nothing there is a real store, a real customer or real money. It is a shared demo on a test machine, not for real customer data. |

Open the demo from the [website](https://zyvorai.github.io/zyvor-retail-site/#demo).

### Sixty seconds: what to click

1. **Read the overview.** See what needs attention, ranked, with one clear action at the top.
2. **Sell something.** Open your shift, press `/`, type a product, press Enter, then enter the cash received to see the change due.
3. **Dig into stock.** Open Products, click a column to sort it, then click a row to see its batches and movements.

Press `?` anywhere in the console to see every shortcut. `Cmd+K` finds anything.

## 2. Run it yourself

The source is private. [Ask for access](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) and you receive a ZIP. You need **Python 3.12 or newer with SQLite support.** There are no application packages, no frontend build step, no CDN and no external service.

Unpack the ZIP, then from its root:

```bash
export RETAIL_ADMIN_EMAIL=owner@zyvor.local
read -s -p 'Initial admin password (12+ characters): ' RETAIL_ADMIN_PASSWORD; printf '\n'
export RETAIL_ADMIN_PASSWORD
python3 -m retail.server --demo
```

Open `http://127.0.0.1:8080` and sign in with the account you chose. The public pickup storefront is at `/shop`. The `--demo` flag seeds a fictional catalogue and stock on an empty database.

**Choose your own password and never commit it.**

## 3. Go further

| Run it as | What it is |
|---|---|
| **Local** | Python 3.12 with SQLite. One command, no packages, no build step, nothing leaves your machine. |
| **Compose with HTTPS** | A standalone stack with Envoy terminating TLS, redirects, rate limits and private operations routes. |
| **Kubernetes** | Non-root pods, probes, default-deny network policies, data and backup volumes, an edge-only autoscaler and a scheduled verified backup. |

Ask [sales](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) for the deployment runbooks that come with an evaluation.

## Pilot it safely

Treat Zyvor Retail as a **pilot**. The core trading, stock and ledger flows work and are tested, but statutory tax, payment and hardware integrations are not there. Run it **alongside your existing process** first, with a controlled pilot whose workflows match the implemented scope. See [Intended use and limits](INTENDED-USE.md).

## Tell us how it went

What worked, what confused you, what you wanted to see: [sales@zyvor.dev](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20feedback), or a **Feedback** issue here (never include customer data, passwords or payment details).
