# FAQ

**Pilot release 0.21.0 · Fictional data only · Not a certified tax or accounting system.**

### Can I run my real shop on it today?
Treat it as a pilot. The core trading, stock, GST invoice and ledger flows work and are tested, but payment gateways, hardware drivers and certified statutory filing are not there. Pilot it alongside your existing process first. See [Intended use and limits](INTENDED-USE.md).

### How do I try it without buying anything?
Three ways: the [guided one-command trial](https://zyvorai.github.io/zyvor-retail-site/try/) on your Mac, Windows or Linux computer; the [live demo](https://zyvorai.github.io/zyvor-retail-site/#demo) in the browser; or ask [sales](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) for a source ZIP.

### Is there AI in it?
Two features. **Suggestions** is a statistical forecast, not a trained model: reorder and expiry advice that shows its arithmetic. **Ask your store** answers plain-language questions from your own records (including a journal tax summary that is not tax advice). By default it uses built-in rules and makes no network call. An optional language model you connect stays off until configured and never sees customer details.

### Does it need the internet or a cloud account?
No. It runs on your own machine or server with Python and SQLite, and the interface uses system fonts and original vector art. No CDN, analytics or external service is called.

### How many stores does it support?
Several under one company: per-branch records, a shared customer directory and catalogue, admin branch switching and immediate transfers. Consolidation across legal entities or currencies is not built.

### Where does the data live?
In a SQLite database on infrastructure you run, with a verified backup job in the Kubernetes deployment. Existing databases upgrade through numbered transactional migrations.

### Does it do GST or e-invoicing?
Pilot tax invoices (INV/CN), CGST/SGST/IGST and GSTR-1 CSV export are included. This is not certified GST software, not e-invoicing, and not live GSTN filing. Not a certified accounting system.

### Can it take card payments?
Tenders (cash, card and UPI, including cash+UPI split) are **recorded, not initiated.** There is no payment gateway.

### Can staff sign in with our identity provider?
Yes, if you turn it on. Optional OpenID Connect (built for Zyvor Haven / Keycloak) adds a sign-in button; only people already added in Retail can sign in. Passwords keep working. The hosted demo does not use it.

### Can I see the source?
The source repository is private. The one-command trial pulls a published container image (no source in the release). Ask [sales](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) what we can share with evaluators.

### Ready for a pilot?
Tell us about your stores. We will walk you through it with a fictional catalogue first: [sales@zyvor.dev](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot).
