#!/bin/bash

# Usage: ./run-certbot.sh admin@example.com example.com [example.org ...]

EMAIL="$1"
shift

if [ -z "$EMAIL" ] || [ "$#" -lt 1 ]; then
  echo "Usage: $0 <email> <domain1> [domain2 ...]"
  exit 1
fi

# Build domain arguments
DOMAIN_ARGS=""
for DOMAIN in "$@"; do
  DOMAIN_ARGS="$DOMAIN_ARGS -d $DOMAIN"
done

# Run certbot inside Docker
certbot certonly \
  --manual --preferred-challenges dns \
  -m "$EMAIL" --agree-tos $DOMAIN_ARGS

# Copy certificates to Windows directory
WIN_CERT_DIR="/mnt/c/letsencrypt/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$WIN_CERT_DIR"
cp -r /etc/letsencrypt/live "$WIN_CERT_DIR/"live
cp -r /etc/letsencrypt/archive "$WIN_CERT_DIR/archive"
cp /etc/letsencrypt/renewal/* "$WIN_CERT_DIR/renewal/"
echo "Certificates copied to $WIN_CERT_DIR"
