#!/bin/bash

# Usage: ./export-to-pfx.sh example.com
DOMAIN="$1"
if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

# Copy certificates to Windows directory
WIN_CERT_DIR="/mnt/c/letsencrypt"
mkdir -p "$WIN_CERT_DIR"

cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /mnt/c/letsencrypt/$DOMAIN.crt
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /mnt/c/letsencrypt/$DOMAIN.key

echo "Certificates copied to $WIN_CERT_DIR"

# Convert to PFX format
openssl pkcs12 -export \
  -out "$WIN_CERT_DIR/$DOMAIN.pfx" \
  -inkey "$WIN_CERT_DIR/$DOMAIN.key" \
  -in "$WIN_CERT_DIR/$DOMAIN.crt"

echo "PFX file created at $WIN_CERT_DIR/$DOMAIN.pfx"
