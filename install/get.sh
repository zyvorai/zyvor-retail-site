#!/bin/sh
# Bootstrap for people without a checkout: downloads the install bundle from the same release as this script, checks its
# checksum, unpacks it under ~/.zyvor-retail/app and runs install.sh with the arguments you give.
#   curl -fsSL https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.sh | sh -s -- up --demo
# Read it first if you like: it is short, and it only writes under ~/.zyvor-retail.
set -eu
BASE="${RETAIL_RELEASE_BASE:-https://github.com/zyvorai/zyvor-retail-site/releases/latest/download}"
APP="${RETAIL_APP_DIR:-$HOME/.zyvor-retail/app}"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
command -v curl >/dev/null 2>&1 || { echo "curl is required" >&2; exit 1; }
curl -fsSL "$BASE/zyvor-retail-install.tar.gz" -o "$tmp/zyvor-retail-install.tar.gz"
curl -fsSL "$BASE/SHA256SUMS" -o "$tmp/SHA256SUMS"
want="$(grep ' zyvor-retail-install.tar.gz$' "$tmp/SHA256SUMS" | cut -d' ' -f1)"
if command -v sha256sum >/dev/null 2>&1; then got="$(sha256sum "$tmp/zyvor-retail-install.tar.gz" | cut -d' ' -f1)"; else got="$(shasum -a 256 "$tmp/zyvor-retail-install.tar.gz" | cut -d' ' -f1)"; fi
[ -n "$want" ] && [ "$want" = "$got" ] || { echo "checksum mismatch for zyvor-retail-install.tar.gz: refusing to run it" >&2; exit 1; }
rm -rf "$APP"; mkdir -p "$APP"; tar -xzf "$tmp/zyvor-retail-install.tar.gz" -C "$APP"
exec "$APP/deploy/install/install.sh" "$@"
