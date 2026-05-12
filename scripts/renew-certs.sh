#!/usr/bin/env bash
# Run this on a cron to auto-renew the Let's Encrypt cert.
# Recommended: add to crontab as  0 3 * * * bash /path/to/renew-certs.sh

cd "$(dirname "$0")/.."
docker compose run --rm certbot renew
docker compose exec nginx nginx -s reload
echo "Cert renewal attempted and nginx reloaded."
