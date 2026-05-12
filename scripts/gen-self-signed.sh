#!/usr/bin/env bash
# Generate a self-signed TLS cert for local / homelab use.
# Run this once before deploying the stack.
#
# Usage:
#   bash scripts/gen-self-signed.sh [your-domain-or-IP]
#   bash scripts/gen-self-signed.sh 192.168.1.100

DOMAIN=${1:-localhost}
SSL_DIR="$(dirname "$0")/../nginx/ssl"
mkdir -p "$SSL_DIR"

openssl req -x509 -nodes -days 3650 \
  -newkey rsa:2048 \
  -keyout "$SSL_DIR/key.pem" \
  -out   "$SSL_DIR/cert.pem" \
  -subj  "/CN=$DOMAIN" \
  -addext "subjectAltName=IP:$DOMAIN,DNS:$DOMAIN" 2>/dev/null || \
openssl req -x509 -nodes -days 3650 \
  -newkey rsa:2048 \
  -keyout "$SSL_DIR/key.pem" \
  -out   "$SSL_DIR/cert.pem" \
  -subj  "/CN=$DOMAIN"

echo "Self-signed cert written to $SSL_DIR/"
echo "  cert.pem  — certificate"
echo "  key.pem   — private key"
