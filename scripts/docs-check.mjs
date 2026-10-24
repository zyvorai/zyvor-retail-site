#!/usr/bin/env node
// Checks the README and docs of the public site repository (no dependencies):
//   - every relative link, image and in-page anchor resolves
//   - README and every docs page carry the required statements (fictional data only, not a certified tax or accounting system)
//   - tax, payment and security-certification words (GST, e-invoicing, PCI, SOC 2, ISO 27001, GDPR, certified, penetration test)
//     only appear next to a negation: we make no such claims
//   node scripts/docs-check.mjs [root]
import { existsSync, readFileSync, readdirSync, statSync } from "node:fs";
import { dirname, join, normalize, relative, resolve } from "node:path";

const root = resolve(process.argv[2] ?? ".");
const skip = new Set([".git", "node_modules", "scripts"]);
const walk = (d) =>
  readdirSync(d).flatMap((n) => {
    if (skip.has(n)) return [];
    const p = join(d, n);
    return statSync(p).isDirectory() ? walk(p) : [p];
  });
const markdown = walk(root).filter((f) => f.endsWith(".md"));
const problems = [];
const rel = (f) => relative(root, f);

const slug = (h) =>
  h.toLowerCase().replace(/<[^>]+>/g, "").replace(/[^\p{L}\p{N}\s-]/gu, "").trim().replace(/\s+/g, "-");

for (const f of markdown) {
  const src = readFileSync(f, "utf8");
  for (const m of src.matchAll(/!?\[[^\]]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g)) {
    const target = m[1];
    if (/^(https?:|mailto:|#)/.test(target)) continue;
    const path = decodeURIComponent(target.split("#")[0]);
    if (path && !existsSync(normalize(join(dirname(f), path)))) problems.push(`${rel(f)}: broken link ${target}`);
  }
  for (const m of src.matchAll(/(?:srcset|src)="([^"]+)"/g)) {
    if (/^(https?:|data:)/.test(m[1])) continue;
    if (!existsSync(normalize(join(dirname(f), m[1])))) problems.push(`${rel(f)}: missing image ${m[1]}`);
  }
  const heads = new Set([...src.matchAll(/^#{1,6}\s+(.+)$/gm)].map((h) => slug(h[1])));
  for (const m of src.matchAll(/\]\(#([^)]+)\)/g)) if (!heads.has(m[1])) problems.push(`${rel(f)}: anchor #${m[1]} has no matching heading`);
}

const needs = [/fictional data only/i, /not a certified (tax|accounting)/i];
for (const f of markdown.filter((f) => ["README.md", "docs"].includes(rel(f).split("/")[0]) && !rel(f).endsWith("GALLERY.md"))) {
  const src = readFileSync(f, "utf8");
  for (const re of needs) if (!re.test(src)) problems.push(`${rel(f)}: missing required statement ${re}`);
}

const RISKY = /\b(GST|e-invoicing|PCI|GDPR|ISO 27001|SOC 2|certified|payment gateway|penetration test|production[- ]ready|enterprise[- ]grade)\b/i;
const NEGATION = /\b(no|not|nor|never|without|neither|isn't|is not|are not|yet)\b/i;
for (const f of markdown) {
  readFileSync(f, "utf8").split("\n").forEach((line, i) => {
    if (RISKY.test(line) && !NEGATION.test(line) && !/^\s*#/.test(line) && !/^\s*\|?\s*[-:| ]+$/.test(line))
      problems.push(`${rel(f)}:${i + 1}: regulatory/clinical wording without a negation: ${line.trim().slice(0, 90)}`);
  });
}

if (problems.length) {
  console.error("docs check FAILED:\n  " + problems.join("\n  "));
  process.exit(1);
}
console.log(`docs check clean: ${markdown.length} markdown files`);
