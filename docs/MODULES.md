# Modules

**Pilot release 0.29.0 · Fictional data only · Not a certified tax or accounting system.**

Retail core plus switchable packs (Restaurant, Aggregators, HR, Tasks). Each row below is implemented and covered by the repository's tests; the limits are in [Intended use and limits](INTENDED-USE.md).

| Module | What it covers |
|---|---|
| **Capability packs** | Settings toggles for Retail, Restaurant, Aggregators, HR and Tasks; navigation and APIs follow what you enable |
| **Point of sale** | Barcode / alt-barcode scan, product search, customers, manager discounts and price-match, promotion codes, cash / card / UPI and split tenders, gift-card redeem, age gate, on-account credit, park/recall bags with optional stock hold, stub SoftPOS intents, printable tax invoices, shifts with deposit/paid-out, blind Z and X/Z report, weighed qty prompt when `unit_scale` is set, serial pick on serial-tracked SKUs, exchange with price-match |
| **Catalogue** | SKU and barcode uniqueness, packs, categories, prices, tax rates, HSN, reorder levels, variants, image URL or local JPEG/PNG/WebP attach, CSV/XLSX import with upsert and column aliases, effective-dated and daypart price schedules, 86/sold-out, allergens, MRP, customer price books |
| **Inventory** | Batches, expiry blocking, FEFO selling, adjustments at actual batch cost, immediate and in-transit transfers, stock-count sessions that detect conflicts, serials, bins, recalls, opening-stock CSV/XLSX import, reorder and expiry suggestions with one-click Propose→Apply (dated markdown or draft PO); per-supplier lead days when set |
| **Purchasing** | Suppliers (optional lead days), multi-line purchase orders (cancel when unreceived), RFQ → quote → award, approval gate, partial receipts with input tax / RCM, three-way match field, unique invoice numbers, invoice text paste → draft PO, copy-only supplier reorder message, replenishment drafts, supplier catalogue SKU/cost, CSV/XLSX supplier import, supplier returns with multi-line RMA limits and cash refunds against credits |
| **Pickup storefront** | Public catalogue, pickup/delivery with preferred time slot, stock reserve, stub OTP and shipments, shop register/login, tracking. Collection links atomically to the sale. |
| **Customers and loyalty** | Company-wide directory with consent, merge, credit limit, phone/email duplicate suggestions, privacy export/erase, CSV/XLSX customer import; earn × multiplier or dated storewide/SKU campaign `earn_bps` into FEFO lots, redeem ₹1/pt, tiers, expire; CRM labels, AR reminder stubs, marketing audience launch |
| **Restaurant (pack)** | Floor, tickets, KOT fire/bump, stations, recipes/BOM, tips and voluntary service charge, modifiers, NC, merge/split settle, tokens, reservations, waitlist, tip pool |
| **Aggregators (pack)** | Channel stubs, ingest/accept, reject/ready/complete/cancel, menu flag, payout import/match — not live Swiggy/Zomato APIs |
| **HR (pack)** | Attendance clock, leave, pay-run draft/post, tip declare, roster shifts — not biometric devices or statutory PF/ESI |
| **Markets** | IN/EU/US/UK/AE market profile (currency, locale, tax-inclusive default, FSSAI, auto-gratuity), gift cards, delivery zones, waste tickets, layaway |

## The books

**Stock and money cannot disagree.** A sale, a receipt, a write-off and a return each write to the stock ledger and to the double-entry journal in the same transaction. There is no end-of-day sync to forget.

- **One commit, two ledgers.** Quoted prices and discounts are checked again at commit. A retried checkout is idempotent and never consumes a promotion twice.
- **GST worksheets in-app.** GSTR-1 / GSTR-3B / CMP-08 / GSTR-9 worksheets, debit notes and advances, ITC claim/utilise/reverse/dispute, composition (+ rate accrual), TCS/TDS withhold + CSV, ISD branch transfer, stub/sandbox IRN/e-Way and GSTR upload/2A/2B JSON import. Not live GSTN filing.
- **Desktop and migration.** Optional native desktop shell; import masters from Tally/Vyapar-style CSV/Excel exports (not native DB readers).
- **Answers, not exports.** Revenue, margin, inventory value, supplier balances, trial balance, date-range profit, paginated journals, year-end pack, royalty report, plus stock and sales CSVs with formula-injection protection.
- **Fixed assets & checklists.** Straight-line depreciation journals; outlet checklist templates, runs, and `schedule_days` spawn.
- **Boundary: not certified GST.** Tax invoices and credit notes with CGST/SGST/IGST are included for pilot use; this is not live NIC/GSTN filing and not a certified accounting system.

## Made for speed

- The overview ranks what needs attention: expired stock, low stock, pickup requests, due tasks. One clear action per item. Suggestions and Zyntra inbox proposals Apply with a manager click (never auto). Or ask: "What should I reorder?" / tax questions answered from journals (not tax advice).
- Scan a barcode and it is in the bag. `/` searches, `+` and `-` change quantity, `Cmd+K` finds anything, `?` lists every shortcut.
- Type the cash received and see the change due, or how much is short. Split tenders on one sale when needed.
- Click any column to sort, switch to compact rows, and open a product, customer, batch or receipt for the full story without leaving the page.
- Every workspace and tab has its own address: share it, bookmark it, press Back. Refresh keeps your place.
- Offline or a failed refresh shows a clear banner with the time of the last good data. Pending sales wait safely; the console shell is cached.

## Not built yet

Live NIC/GSTN submission, live SoftPOS / bank / SMS / shipping / ESC-POS drivers, live Swiggy/Zomato and gift-card processors, live supplier EDI / CDP campaign sync, biometric clocks and statutory PF/ESI, auto-apply without a human click, Companies Act depreciation schedules, forecasting beyond Suggestions, PostgreSQL / application HA.

Back to the [documentation index](README.md).
