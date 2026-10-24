#!/usr/bin/env bash
# Renders this repository's images from HTML with headless Chrome (nothing is installed):
#   docs/assets/social-preview.png  1280x640  upload under Settings > Social preview
#   docs/assets/readme-hero.jpg     2400x1200 top of the README
# The cards use only the fictional-data screenshots already in shots/.
#   docs/social/build-social.sh
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/../assets"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
[[ -x "$CHROME" ]] || { echo "Google Chrome not found (set CHROME=...)" >&2; exit 1; }
mkdir -p "$OUT"
TMP="$(mktemp -d "${TMPDIR:-/tmp}/retail-social.XXXXXX")"
trap 'rm -rf "$TMP"' EXIT
shot() { # html width height scale out
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor="$4" \
    --window-size="$2,$3" --screenshot="$5" "file://$HERE/$1" >/dev/null 2>&1
}
shot social-preview.html 1280 640 1 "$OUT/social-preview.png"
shot readme-hero.html 1200 600 2 "$TMP/hero.png"
sips -s format jpeg -s formatOptions 88 "$TMP/hero.png" --out "$OUT/readme-hero.jpg" >/dev/null
echo "wrote docs/assets/social-preview.png and readme-hero.jpg"
