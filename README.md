# test3: Multi-App Apptainer Stack with Prefix Routing

This setup demonstrates a production-style organization for multiple Flask apps running as separate Apptainer instances, with path-prefix routing (for example `www.xxx.de/app1`, `www.xxx.de/app2`).

## What is industry-standard for Apptainer?
There is no single widely adopted, first-party "docker-compose equivalent" for Apptainer in production.

Common production pattern:
1. Build one `.sif` image per app.
2. Run each app as an Apptainer instance.
3. Manage lifecycle with `systemd` (or scheduler in HPC environments).
4. Put an HTTP reverse proxy (Apache/Nginx/Traefik) in front for domain/path routing and TLS.
5. Keep runtime config in env files (`.env` style), not hardcoded in `Apptainer.def`.

This repository follows that pattern.

## Layout
```text
/home/sankaran2/apps/test3
├── services
│   ├── dashboard
│   │   ├── app/
│   │   ├── Apptainer.def
│   │   ├── entrypoint.sh
│   │   ├── requirements.txt
│   │   └── wsgi.py
│   ├── app1
│   │   ├── app/
│   │   ├── Apptainer.def
│   │   ├── entrypoint.sh
│   │   ├── requirements.txt
│   │   └── wsgi.py
│   └── app2
│       ├── app/
│       ├── Apptainer.def
│       ├── entrypoint.sh
│       ├── requirements.txt
│       └── wsgi.py
├── deploy
│   ├── env
│   │   ├── dashboard.env
│   │   ├── app1.env
│   │   └── app2.env
│   ├── reverse-proxy
│   │   └── httpd-vhost.conf
│   └── systemd
│       └── apptainer-stack.service
└── scripts
    ├── build-all.sh
    ├── start-all.sh
    ├── stop-all.sh
    ├── status-all.sh
    ├── start-one.sh
    └── stop-one.sh
```

## Config model
- Per-service runtime config is in `deploy/env/<service>.env`.
- Required keys per app: `SERVICE_NAME`, `SERVICE_PORT`, `URL_PREFIX`, `GUNICORN_WORKERS`, `GUNICORN_THREADS`.
- Scripts assume naming convention from `SERVICE_NAME`:
  - image path: `services/$SERVICE_NAME/$SERVICE_NAME.sif`
  - instance name: `$SERVICE_NAME`
- `Apptainer.def` files are generic and **do not** hardcode ports.
- Ports are passed as runtime arguments to instance start.
- `URL_PREFIX`, `GUNICORN_WORKERS`, and `GUNICORN_THREADS` are injected using `APPTAINERENV_*` variables.

## Independent repo model
Each folder under `services/*` can be its own git repo:
- app code + `wsgi.py` + `requirements.txt` + `Apptainer.def` + `entrypoint.sh`
- build/run independently:
```bash
cd services/app1
apptainer build app1.sif Apptainer.def
APPTAINERENV_URL_PREFIX=/app1 APPTAINERENV_GUNICORN_WORKERS=1 APPTAINERENV_GUNICORN_THREADS=2 apptainer run app1.sif 8071
```

## Stack usage
```bash
cd /home/sankaran2/apps/test3
./scripts/build-all.sh
./scripts/start-all.sh
./scripts/status-all.sh
```

Stop all:
```bash
./scripts/stop-all.sh
```

Start one service:
```bash
./scripts/start-one.sh app1
```

## Reverse proxy
Use `deploy/reverse-proxy/httpd-vhost.conf` as the Apache path-routing template:
- `/dashboard` -> dashboard service
- `/app1` -> app1 service
- `/app2` -> app2 service

This enables URLs like:
- `https://www.xxx.de/dashboard`
- `https://www.xxx.de/app1`
- `https://www.xxx.de/app2`

## Notes
- Path-prefix behavior is app-aware via `URL_PREFIX` env var.
- If your environment restricts rootless container networking, run instances in host network mode (default without `--net`) and let reverse proxy handle external routing.
