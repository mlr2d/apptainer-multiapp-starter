# Apptainer Multi-App Starter

Template repository for running multiple Flask services as separate Apptainer instances, with optional path-based routing through Apache httpd.

## Why this layout
This repository uses a simple pattern that scales from local testing to server deployment:
1. One service directory per app (`services/<service>`).
2. One Apptainer image (`.sif`) and one instance per app.
3. One env file per app (`deploy/env/<service>.env`) as runtime configuration.
4. One reverse proxy layer for URL-prefix routing (`/dashboard`, `/app1`, `/app2`).
5. Optional systemd unit for start/stop at system level.

## Repository structure
```text
/home/sankaran2/apps/apptainer-multiapp-starter
├── services
│   ├── dashboard
│   ├── app1
│   └── app2
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

## Runtime configuration model
Each service has one env file under `deploy/env/`.

Required keys:
- `SERVICE_NAME`
- `SERVICE_PORT`
- `URL_PREFIX`
- `GUNICORN_WORKERS`
- `GUNICORN_THREADS`

Naming convention used by scripts:
- image path: `services/$SERVICE_NAME/$SERVICE_NAME.sif`
- instance name: `$SERVICE_NAME`

At start time, scripts pass these values into the container via `APPTAINERENV_*` (for `URL_PREFIX`, `GUNICORN_WORKERS`, `GUNICORN_THREADS`) and pass the port as the start argument.

## Basic workflow
```bash
cd /home/sankaran2/apps/apptainer-multiapp-starter
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

## Running a single service independently
```bash
cd /home/sankaran2/apps/apptainer-multiapp-starter/services/app1
apptainer build app1.sif Apptainer.def
APPTAINERENV_URL_PREFIX=/app1 APPTAINERENV_GUNICORN_WORKERS=1 APPTAINERENV_GUNICORN_THREADS=2 apptainer run app1.sif 8071
```

## Reverse proxy and systemd
- Apache httpd template: `deploy/reverse-proxy/httpd-vhost.conf`
- systemd unit template: `deploy/systemd/apptainer-stack.service`

See the README files in those folders for deployment details.

## Notes
- `Apptainer.def` files are intentionally generic and do not hardcode ports.
- Host-network mode (no `--net`) is typically the simplest non-root setup.
