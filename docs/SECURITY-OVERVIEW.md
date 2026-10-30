# Security overview

**Pilot release 0.24.0 · Fictional data only · Not a certified tax or accounting system.**

The controls you can point at in a pilot, and what has **not** been done. To report a vulnerability, read [SECURITY.md](../SECURITY.md).

## Controls

| Area | What is in place |
|---|---|
| **Sign-in** | Hashed passwords, opaque HttpOnly sessions, CSRF protection, persistent throttle counters, and session revocation. |
| **Access** | Five roles with branch scope, checked on the server. Staff can be disabled, and passwords changed by admins or by the person themselves. |
| **Network edge** | An Envoy edge with HTTPS, HTTP redirects, token buckets, body and header limits, timeouts, and private routes for backup and metrics. |
| **Data integrity** | Transactional writes: a sale, receipt, write-off or return writes to the stock ledger and the double-entry journal in one commit; a retried checkout is idempotent. |
| **Exports** | Stock and sales CSVs with formula-injection protection. |
| **Offline** | No CDN, analytics or external service is called. |

## What has not been done

- **No independent security review yet.**
- **No MFA of its own**, no audit signing, and no encrypted application fields. Optional OIDC SSO is available and off by default. Database files and checkout drafts are not encrypted by the application; host and browser access controls matter.
- **Payments are recorded, not initiated**, so no card data flows through the application.
- **One application instance on SQLite**, with no high availability yet; container and cluster validation is still to be run in your environment.

Before exposing it to real customers, review transport and gateway configuration, account lifecycle, least-privilege access, customer data retention and deletion, backup handling, public-order abuse, audit retention and the payment and tax integrations you need.

## Reporting a vulnerability

Email **[security@zyvor.dev](mailto:security@zyvor.dev)**. Please do not include customer data, passwords or payment details, and do not open a public issue for a vulnerability. Details: [SECURITY.md](../SECURITY.md).
