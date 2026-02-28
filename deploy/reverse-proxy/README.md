# Reverse Proxy (Apache httpd)

This folder contains Apache reverse-proxy configuration for routing URL prefixes to Apptainer services.

## Files
- `httpd-vhost.conf`: VirtualHost template for `www.xxx.de`.

## What it does
- Routes `/dashboard` to dashboard service port.
- Routes `/app1` to app1 service port.
- Routes `/app2` to app2 service port.

## Prerequisites
Enable Apache modules:
```bash
sudo a2enmod proxy proxy_http headers
```

## Deploy steps
1. Copy or include `httpd-vhost.conf` in your Apache site config.
2. Adjust domain and ports to match `deploy/env/*.env`.
3. Reload Apache:
```bash
sudo systemctl reload httpd
```
(Use `apache2` instead of `httpd` on Debian/Ubuntu if needed.)

## Notes
- URL prefixes in Apache must match each app's `URL_PREFIX` in `deploy/env/*.env`.
- Ports in Apache must match each app's `SERVICE_PORT`.
