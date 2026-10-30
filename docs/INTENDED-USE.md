# Intended use and limits

**Pilot release 0.22.0 · Fictional data only · Not a certified tax or accounting system.**

A long feature list does not prove a commercial launch. This is what Zyvor Retail is not, yet, taken from the product's own release scope.

| Area | Where it stands |
|---|---|
| **Maturity** | A pilot release with a working core. Start with a controlled pilot whose workflows match the implemented scope. |
| **Tax and statutory** | Tax invoices (INV/CN), place-of-supply CGST/SGST/IGST, GSTR-1/3B worksheets, ITC, composition rate accrual, TCS/TDS worksheet CSV, ISD transfers, stub IRN/e-Way and portal acks are included for pilot use. Not certified GST software, not live GSTN filing, not Form 26Q/27EQ challans. Not a certified accounting system. |
| **Payments and hardware** | Tenders are recorded, not initiated (stub SoftPOS intents). Cash/card/UPI split and on-account credit are supported. No live payment gateway, calibrated scale drivers or fiscal printer drivers. |
| **Offline** | Service worker caches the console shell; a loaded tab keeps a pending checkout for manual retry and a last catalogue snapshot for brief disconnect. It is not a full offline POS. |
| **Ask your store** | Read-only questions from your own records, including a GST liability view from journals. Built-in rules understand a limited set of questions; a language model you connect (off by default) can still be wrong. Not tax advice. |
| **Suggestions** | Statistical estimates from your own sales, not a trained model. They need about three weeks of history, do not know about promotions or festivals, and use one lead time for the whole store. Nothing is ordered or marked down unless a person submits it. |
| **Storefront** | Pickup and delivery requests with stock reserve, stub OTP/ship, shop accounts. No live SMS OTP carriers or live shipping APIs. |
| **Security** | Optional TOTP MFA and OIDC SSO (off by default). No independent review yet, no audit signing, no encrypted application fields. |
| **Scale** | One application instance on SQLite. No application high availability and no PostgreSQL migration yet; container and cluster validation is still to be run in your environment. |
| **Not built yet** | Live NIC/GSTN, live SoftPOS/bank/SMS/ship/ESC-POS, supplier catalogues, CRM campaigns, payroll/rostering, Companies Act depreciation packs, forecasting beyond Suggestions. |

## In practice

- **Pilot it** alongside your existing process. Do not rely on it for statutory tax filing or as your only books.
- The demo uses **fictional data only.** Please do not put real customer records, passwords or payment details into a demo.
- Consolidation across legal entities or currencies is not built.

Questions: [sales@zyvor.dev](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) · [security@zyvor.dev](mailto:security@zyvor.dev)
