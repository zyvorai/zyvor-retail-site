# Intended use and limits

**Pilot release 0.11.0 · Fictional data only · Not a certified tax or accounting system.**

A long feature list does not prove a commercial launch. This is what Zyvor Retail is not, yet, taken from the product's own release scope.

| Area | Where it stands |
|---|---|
| **Maturity** | A pilot release with a working core. Start with a controlled pilot whose workflows match the implemented scope. |
| **Tax and statutory** | Pilot tax invoices (INV/CN), place-of-supply CGST/SGST/IGST, purchase input tax and GSTR-1 CSV export are included for accountants. Not certified GST software, not e-invoicing, not live GSTN filing, no period close or year-end. Not a certified accounting system. |
| **Payments and hardware** | Tenders are recorded, not initiated. Cash+UPI split on one sale is supported. No payment gateway, credit sales, calibrated scales or fiscal printer drivers. |
| **Offline** | Service worker caches the console shell; a loaded tab keeps a pending checkout for manual retry and a last catalogue snapshot for brief disconnect. It is not a full offline POS. |
| **Ask your store** | Read-only questions from your own records, including a GST liability view from journals. Built-in rules understand a limited set of questions; a language model you connect (off by default) can still be wrong. Not tax advice. |
| **Suggestions** | Statistical estimates from your own sales, not a trained model. They need about three weeks of history, do not know about promotions or festivals, and use one lead time for the whole store. Nothing is ordered or marked down unless a person submits it. |
| **Storefront** | Pickup only: no online payment, accounts, delivery, reserved stock, order tracking or verified phone ownership. |
| **Security** | No independent review yet, no MFA of its own, no audit signing, no encrypted application fields. Optional OIDC SSO is available and off by default. |
| **Scale** | One application instance on SQLite. No application high availability and no PostgreSQL migration yet; container and cluster validation is still to be run in your environment. |
| **Not built yet** | Variants, serial numbers, bins, recalls, RFQs, PO approval chains, three-way matching, e-Invoice IRN, e-Way bill, live GSTN push, payroll, rostering, franchise royalties, forecasting. |

## In practice

- **Pilot it** alongside your existing process. Do not rely on it for statutory tax filing or as your only books.
- The demo uses **fictional data only.** Please do not put real customer records, passwords or payment details into a demo.
- Consolidation across legal entities or currencies is not built.

Questions: [sales@zyvor.dev](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) · [security@zyvor.dev](mailto:security@zyvor.dev)
