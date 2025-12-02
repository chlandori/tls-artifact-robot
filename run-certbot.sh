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
docker run --rm \
  -v /mnt/c/letsencrypt:/etc/letsencrypt \
  tls-artifact-robot certbot certonly \
  --standalone -m "$EMAIL" --agree-tos $DOMAIN_ARGS
