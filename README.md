# nginx-https-portainer

Nginx serving HTTPS on **port 6532** with a real **Let's Encrypt certificate** for `netdes.xyz`, deployable as a Portainer stack.

---

## Prerequisites

- Port **80** must be open and reachable from the internet (required for the ACME HTTP-01 challenge).
- Port **6532** must be open for HTTPS traffic.
- Your domain `netdes.xyz` must have an **A record pointing to your server's public IP**.

---

## Deploy via Portainer

### Option A — Git repository (recommended)

1. Portainer → **Stacks → Add stack → Repository**
2. URL: `https://github.com/RexiFay/nginx-https-portainer`
3. Compose path: `docker-compose.yml`
4. Click **Deploy the stack**

On first deploy, Certbot will run, obtain the cert for `netdes.xyz` and `www.netdes.xyz`, then Nginx will start with HTTPS.

### Option B — Manual / Web editor

Copy-paste `docker-compose.yml` into the Portainer web editor and deploy.

---

## First-time flow

```
1. Certbot container starts → requests cert via HTTP-01 on port 80
2. Nginx verifies the challenge file at /.well-known/acme-challenge/
3. Let's Encrypt issues cert → stored in the certbot-certs volume
4. Nginx starts on port 6532 using /etc/letsencrypt/live/netdes.xyz/fullchain.pem
```

---

## Verify

```bash
curl https://netdes.xyz:6532/health
# → ok
```

---

## Auto-renew certs

Add a cron job on your server:

```bash
crontab -e
# Add this line:
0 3 * * * bash /path/to/nginx-https-portainer/scripts/renew-certs.sh
```

Or run manually:
```bash
bash scripts/renew-certs.sh
```

---

## File layout

```
.
├── docker-compose.yml          # Nginx + Certbot stack
├── nginx/
│   ├── conf.d/
│   │   └── default.conf        # HTTP redirect + HTTPS on 6532
│   └── html/
│       └── index.html          # Default welcome page
├── scripts/
│   └── renew-certs.sh          # Cert renewal helper
└── .gitignore
```

---

## Changing the port

Edit `docker-compose.yml` ports and `default.conf` `listen` line to match.

---

## License

MIT
