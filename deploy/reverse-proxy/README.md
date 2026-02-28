# Reverse Proxy (Apache httpd)

This folder contains Apache configuration for routing URL prefixes to local Apptainer services.

## File
- `httpd-vhost.conf`: example VirtualHost for `www.xxx.de`

## Routing model
- `/dashboard` -> dashboard service port
- `/app1` -> app1 service port
- `/app2` -> app2 service port

## Prerequisites
Enable required Apache modules:

Debian/Ubuntu:
```bash
sudo a2enmod proxy proxy_http headers
```

RHEL/Rocky/Alma:
- Ensure proxy modules are loaded in Apache config (`mod_proxy`, `mod_proxy_http`, `mod_headers`).

## Deployment steps
1. Copy or include `httpd-vhost.conf` in your Apache site config.
2. Adjust domain, prefixes, and ports to match `deploy/env/*.env`.
3. Reload Apache:
```bash
sudo systemctl reload httpd
```
(Use `apache2` instead of `httpd` on Debian/Ubuntu if needed.)

## Validation checklist
- Prefixes in Apache match each service `URL_PREFIX`.
- Backend ports in Apache match each service `SERVICE_PORT`.
- Apptainer instances are running before Apache routes traffic.
