# FAQ

**Pilot release 0.6.2 · Fictional data only · Not a certified tax or accounting system.**

### Can I run my real shop on it today?
Treat it as a pilot. The core trading, stock and ledger flows work and are tested, but statutory tax, payment and hardware integrations are not there. Pilot it alongside your existing process first. See [Intended use and limits](INTENDED-USE.md).

### Is there AI in it?
There is a **statistical forecast, no trained model.** Suggestions turns your own sales history into reorder and expiry advice that shows the numbers behind every line, runs on your machine and makes no network call. Language features through an OpenAI-compatible endpoint are planned as an optional layer; none ship today.

### Does it need the internet or a cloud account?
No. It runs on your own machine or server with Python and SQLite, and the interface uses system fonts and original vector art. No CDN, analytics or external service is called.

### How many stores does it support?
Several under one company: per-branch records, a shared customer directory and catalogue, admin branch switching and immediate transfers. Consolidation across legal entities or currencies is not built.

### Where does the data live?
In a SQLite database on infrastructure you run, with a verified backup job in the Kubernetes deployment. Existing databases upgrade through numbered transactional migrations.

### Does it do GST or e-invoicing?
No. It is a sound **management** ledger, not statutory GST, e-invoicing or a certified accounting system.

### Can it take card payments?
Tenders (cash, card and UPI) are **recorded, not initiated.** There is no payment gateway.

### Can I see the source?
The source repository is private. Ask [sales](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot) what we can share with evaluators.

### Ready for a pilot?
Tell us about your stores. We will walk you through it with a fictional catalogue first: [sales@zyvor.dev](mailto:sales@zyvor.dev?subject=Zyvor%20Retail%20pilot).
