# Reverse Proxy (Apache httpd)

Apache vhost template for path-prefix routing to local Apptainer services.

## File
- `httpd-vhost.conf`

## Routing
- `/main` -> `main` service
- `/app1` -> `app1` service
- `/app2` -> `app2` service

## Setup
1. Copy/include `httpd-vhost.conf` in Apache config.
2. Ensure prefixes and ports match each service `config.env`.
3. Reload Apache:
```bash
sudo systemctl reload httpd
```
