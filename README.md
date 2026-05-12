# nginx-https-portainer

Nginx serving HTTPS on **port 6532**, packaged as a Docker Compose stack ready for [Portainer](https://portainer.io).

---

## Quick start

### 1. Generate a self-signed TLS cert (first time only)

```bash
bash scripts/gen-self-signed.sh <your-server-IP-or-domain>
```

This writes `nginx/ssl/cert.pem` and `nginx/ssl/key.pem`. Those files are in `.gitignore` and will **never** be committed.

> **Production tip:** Replace the self-signed cert with a real one from Let's Encrypt (Certbot/acme.sh) and mount it at the same paths.

---

### 2. Deploy via Portainer

#### Option A — Git repository (recommended)

1. Open **Portainer → Stacks → Add stack → Repository**
2. Paste the repo URL: `https://github.com/RexiFay/nginx-https-portainer`
3. Set **Compose path** to `docker-compose.yml`
4. Make sure `nginx/ssl/cert.pem` and `nginx/ssl/key.pem` exist on the host before deploying (step 1 above).
5. Click **Deploy the stack**.

#### Option B — Upload / Web editor

Copy-paste the contents of `docker-compose.yml` directly into the Portainer web editor.

---

### 3. Verify

```bash
curl -k https://localhost:6532/health
# expected output:  ok
```

Or open `https://<your-server>:6532` in a browser (accept the self-signed cert warning).

---

## File layout

```
.
├── docker-compose.yml          # Stack definition
├── nginx/
│   ├── conf.d/
│   │   └── default.conf        # Nginx HTTPS server block
│   ├── html/
│   │   └── index.html          # Default welcome page
│   └── ssl/                    # ← place cert.pem and key.pem here (gitignored)
├── scripts/
│   └── gen-self-signed.sh      # Helper: generate a self-signed cert
└── .gitignore
```

---

## Swapping in a real cert

Mount any PEM-format cert chain and key at:

| Container path | What to put there |
|---|---|
| `/etc/nginx/ssl/cert.pem` | Full-chain certificate |
| `/etc/nginx/ssl/key.pem` | Private key |

No changes to `docker-compose.yml` or `default.conf` are needed.

---

## Changing the port

Edit the `ports` entry in `docker-compose.yml`:

```yaml
ports:
  - "NEW_PORT:443"
```

---

## License

MIT
