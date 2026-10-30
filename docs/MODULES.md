# Modules

**Pilot release 0.21.0 · Fictional data only · Not a certified tax or accounting system.**

Ten workspaces, from point of sale to settings. Each row below is implemented and covered by the repository's tests; the limits are in [Intended use and limits](INTENDED-USE.md).

| Module | What it covers |
|---|---|
| **Point of sale** | Barcode / alt-barcode scan, product search, customers, manager discounts, promotion codes, cash / card / UPI and split tenders, on-account credit, stub SoftPOS intents, printable tax invoices, shifts with counted-versus-expected cash, weighed qty prompt when `unit_scale` is set, serial pick on serial-tracked SKUs, exchange with price-match |
| **Catalogue** | SKU and barcode uniqueness, packs, categories, prices, tax rates, HSN, reorder levels, variants, image URL, CSV import, effective-dated price schedules |
| **Inventory** | Batches, expiry blocking, FEFO selling, adjustments at actual batch cost, immediate and in-transit transfers, stock-count sessions that detect conflicts, serials, bins, recalls, reorder and expiry suggestions |
| **Purchasing** | Suppliers, multi-line purchase orders, RFQ → quote → award, approval gate, partial receipts with input tax / RCM, three-way match field, unique invoice numbers, replenishment drafts, supplier catalogue SKU/cost, supplier returns with RMA link and cash refunds against credits |
| **Pickup storefront** | Public catalogue, pickup/delivery requests, stock reserve, stub OTP and shipments, shop register/login, tracking. Collection links atomically to the sale. |
| **Customers and loyalty** | Company-wide directory with consent, merge, credit limit, phone/email duplicate suggestions, privacy export/erase; earn × multiplier or dated campaign `earn_bps` into FEFO lots, redeem ₹1/pt, tiers, expire |

## The books

**Stock and money cannot disagree.** A sale, a receipt, a write-off and a return each write to the stock ledger and to the double-entry journal in the same transaction. There is no end-of-day sync to forget.

- **One commit, two ledgers.** Quoted prices and discounts are checked again at commit. A retried checkout is idempotent and never consumes a promotion twice.
- **GST worksheets in-app.** GSTR-1 / GSTR-3B worksheets, ITC claim/utilise/reverse/dispute, composition (+ rate accrual), TCS/TDS withhold + CSV, ISD branch transfer, stub IRN/e-Way and GSTR upload/2A/2B. Not live GSTN filing.
- **Answers, not exports.** Revenue, margin, inventory value, supplier balances, trial balance, date-range profit, paginated journals, year-end pack, royalty report, plus stock and sales CSVs with formula-injection protection.
- **Fixed assets & checklists.** Straight-line depreciation journals; outlet checklist templates, runs, and `schedule_days` spawn.
- **Boundary: not certified GST.** Tax invoices and credit notes with CGST/SGST/IGST are included for pilot use; this is not live NIC/GSTN filing and not a certified accounting system.

## Made for speed

- The overview ranks what needs attention: expired stock, low stock, pickup requests, due tasks. One clear action per item. Or ask: "What should I reorder?" / tax questions answered from journals (not tax advice).
- Scan a barcode and it is in the bag. `/` searches, `+` and `-` change quantity, `Cmd+K` finds anything, `?` lists every shortcut.
- Type the cash received and see the change due, or how much is short. Split tenders on one sale when needed.
- Click any column to sort, switch to compact rows, and open a product, customer, batch or receipt for the full story without leaving the page.
- Every workspace and tab has its own address: share it, bookmark it, press Back. Refresh keeps your place.
- Offline or a failed refresh shows a clear banner with the time of the last good data. Pending sales wait safely; the console shell is cached.

## Not built yet

Live NIC/GSTN submission, live SoftPOS / bank / SMS / shipping / ESC-POS drivers, live supplier EDI / CDP campaign sync, payroll and rostering, Companies Act depreciation schedules, forecasting beyond Suggestions, PostgreSQL / application HA.

Back to the [documentation index](README.md).
