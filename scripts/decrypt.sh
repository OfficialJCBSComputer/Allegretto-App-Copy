#!/usr/bin/env bash
set -euo pipefail

ENCFILE=".env.enc"
OUTFILE=".env"

if [ ! -f "$ENCFILE" ]; then
  echo "Error: $ENCFILE not found" >&2
  exit 1
fi

if [ -z "${PASSWORD:-}" ]; then
  read -rsp "Enter decryption password: " PASSWORD
  echo
fi

openssl enc -aes-256-cbc -pbkdf2 -iter 600000 -md sha256 \
  -d -in "$ENCFILE" -out "$OUTFILE" -pass "pass:$PASSWORD"

echo "Decrypted -> $OUTFILE"
