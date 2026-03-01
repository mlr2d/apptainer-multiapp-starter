# Reverse Proxy (Apache httpd)

Apache VirtualHost template for path-based routing to local Apptainer services.

## File
- `httpd-vhost.conf`

## Routing model
- `/main` -> `main` service
- `/app1` -> `app1` service
- `/app2` -> `app2` service

## Setup
1. Include `httpd-vhost.conf` in Apache site configuration.
2. Match paths/ports to each service `config.env`.
3. Reload Apache:
```bash
sudo systemctl reload httpd
```
