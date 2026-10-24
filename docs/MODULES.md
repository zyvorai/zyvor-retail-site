# Modules

**Pilot release 0.6.2 · Fictional data only · Not a certified tax or accounting system.**

Ten workspaces, from point of sale to settings. Each row below is implemented and covered by the repository's tests; the limits are in [Intended use and limits](INTENDED-USE.md).

| Module | What it covers |
|---|---|
| **Point of sale** | Barcode keyboard input, product search, customers, manager discounts, promotion codes, cash, card and UPI tender recording, printable receipts, shifts with counted-versus-expected cash |
| **Catalogue** | SKU and barcode uniqueness, packs, categories, prices, tax rates, reorder levels, and CSV import from the browser or the command line |
| **Inventory** | Batches, expiry blocking, FEFO selling, adjustments at actual batch cost, transfers between stores, stock-count sessions that detect conflicts, and reorder and expiry suggestions that show their arithmetic |
| **Purchasing** | Suppliers, multi-line purchase orders, partial receipts, unique invoice numbers, replenishment drafts, and supplier returns against credits |
| **Pickup storefront** | A public catalogue with product sheets, a bag that counts, and a pickup request that ends in a clear timeline. Staff mark orders ready or cancelled; collection links atomically to the sale. |
| **Customers and loyalty** | One company-wide directory with a consent flag, and one point earned per ₹100, reversed if the sale is returned |

## The books

**Stock and money cannot disagree.** A sale, a receipt, a write-off and a return each write to the stock ledger and to the double-entry journal in the same transaction. There is no end-of-day sync to forget.

- **One commit, two ledgers.** Quoted prices and discounts are checked again at commit. A retried checkout is idempotent and never consumes a promotion twice.
- **Answers, not exports.** Revenue, margin, inventory value, supplier balances, trial balance and date-range profit, plus stock and sales CSVs with formula-injection protection.
- **Boundary: not statutory GST.** It is a sound management ledger, not e-invoicing or a certified accounting system.

## Made for speed

- The overview ranks what needs attention: expired stock, low stock, pickup requests, due tasks. One clear action per item.
- Scan a barcode and it is in the bag. `/` searches, `+` and `-` change quantity, `Cmd+K` finds anything, `?` lists every shortcut.
- Type the cash received and see the change due, or how much is short.
- Click any column to sort, switch to compact rows, and open a product, customer, batch or receipt for the full story without leaving the page.
- Every workspace and tab has its own address: share it, bookmark it, press Back. Refresh keeps your place.
- Offline or a failed refresh shows a clear banner with the time of the last good data. Pending sales wait safely.

## Not built yet

Variants, serial numbers, bins, recalls, RFQs, PO approval chains, three-way matching, payroll, rostering, franchise royalties and forecasting beyond the statistical Suggestions.

Back to the [documentation index](README.md).
