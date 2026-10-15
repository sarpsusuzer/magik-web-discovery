#!/bin/sh
# Builds index.html (the deployed page) from app.html.
# Web3Forms access key: read from .web3forms-key or the WEB3FORMS_KEY env var.
set -e
cd "$(dirname "$0")"
KEY="${WEB3FORMS_KEY:-$(cat .web3forms-key 2>/dev/null || true)}"
{
  printf '<!doctype html>\n<html lang="tr">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  sed "s/var WEB3FORMS_KEY = '';/var WEB3FORMS_KEY = '$KEY';/" app.html
  printf '\n</body>\n</html>\n'
} > index.html
[ -n "$KEY" ] && echo "built with Web3Forms key" || echo "built in local mode (no key)"
