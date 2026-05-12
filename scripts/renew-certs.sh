#!/usr/bin/env bash
# Renew Let's Encrypt cert using standalone mode.
# Cron: 0 3 * * * bash /path/to/renew-certs.sh

cd "$(dirname "$0")/.."
docker compose run --rm -p 8088:80 certbot renew --standalone
docker compose exec nginx nginx -s reload
echo "Cert renewed and nginx reloaded."
