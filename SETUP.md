# TemplateVault Tools — Marketplace starter

This package provides a responsive storefront, product search and category filters, Supabase Auth UI, a Supabase schema, and Netlify Functions that initialize Paystack or Flutterwave checkout. **It is not production-ready yet.** Do not accept live payments until the requirements below are finished.

## Deploy
1. Unzip this package.
2. Upload the folder contents to Netlify, or connect the folder through a Git repository. Ensure Netlify deploys the `netlify/functions` directory.
3. Keep your free `*.netlify.app` address. Set `SITE_URL` to that full HTTPS address.

## Accounts with Supabase
1. Create a project at https://supabase.com/.
2. Run `sql/schema.sql` in its SQL Editor.
3. Enable email/password authentication and configure the allowed site URL.
4. Copy `config.example.js` to `config.js`, fill in your Supabase project URL and public anon key, and deploy again. Add `<script src="/config.js"></script>` before `app.js` (already present in `index.html`).
5. Never put a Supabase service-role key or payment secret in browser code.

## Netlify environment variables
In Site configuration → Environment variables, set `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SITE_URL`, `PAYSTACK_SECRET_KEY`, and `FLW_SECRET_KEY`. Secret payment keys must remain server-side. Start with provider test keys and never share secrets in chat.

## REQUIRED before production payments
- Add Paystack and Flutterwave webhook endpoints and verify signatures against their current official documentation.
- Verify payment status, currency, amount, provider reference, user, and product on the server.
- Create pending orders before checkout and mark them paid only after a verified webhook or server-side transaction verification.
- Store downloads in private storage and issue short-lived signed URLs only for paid orders.
- Implement admin product management through server-side endpoints that check a trusted admin allowlist.
- Add rate limits, logging, idempotency, refunds, real customer support contact, privacy notice, and terms.
- Test successful, failed, pending, duplicate, refunded, and delayed payments. A redirect back to the site is not proof of payment.
- The included product catalog and amounts are demo data; the function uses fixed server-side prices (amounts are in kobo, e.g. 450000 = ₦4,500).

## Document policy
This marketplace is designed for legitimate templates and guides: business forms, personal finance tools, application checklists, photo preparation guidance, and clearly labelled sample layouts. Do not offer counterfeit identity cards, birth certificates, SSNs, or bank-issued statements. Direct users to official issuing authorities for real documents.

## Current limitations
The starter does not yet include a completed admin dashboard, verified payment fulfillment, protected digital downloads, or a fully operational order history. Those are production milestones, not enabled features.
