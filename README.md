# Apptainer Multi-App Starter

Generic template for running multiple Flask services as independent Apptainer instances.

## Overview
This repository uses a simple, repeatable structure:
- each service has its own folder under `services/`
- each service builds one `.sif` image
- each service runs as one Apptainer instance
- top-level scripts manage build/start/stop/status for all services

## Structure
```text
/home/sankaran2/apps/apptainer-multiapp-starter
├── data
├── scripts
│   ├── build-all.sh
│   ├── start-all.sh
│   ├── stop-all.sh
│   ├── status-all.sh
│   ├── reverse-proxy
│   │   ├── httpd-vhost.conf
│   │   └── README.md
│   └── systemd
│       ├── apptainer-stack.service
│       └── README.md
└── services
    ├── main
    │   ├── app/
    │   ├── Apptainer.def
    │   ├── build.sh
    │   ├── config.env
    │   ├── start.sh
    │   ├── stop.sh
    │   ├── requirements.txt
    │   └── wsgi.py
    ├── app1
    └── app2
```

## Service configuration
Each service defines runtime config in `services/<service>/config.env`.

Required keys:
- `SERVICE_NAME`
- `SERVICE_PORT`
- `APPTAINERENV_URL_PREFIX`
- `DATA_BIND` (`host_path:container_path`)
- `APPTAINERENV_GUNICORN_WORKERS`
- `APPTAINERENV_GUNICORN_THREADS`

## Usage
```bash
cd /home/sankaran2/apps/apptainer-multiapp-starter
./scripts/build-all.sh
./scripts/start-all.sh
./scripts/status-all.sh
./scripts/stop-all.sh
```

Single service example:
```bash
./services/app1/build.sh
./services/app1/start.sh
./services/app1/stop.sh
```

## Notes
- `Apptainer.def` files remain generic; runtime values come from `config.env`.
- Data mounts are controlled through `DATA_BIND`.
- Use the reverse-proxy and systemd templates under `scripts/` for production-style deployments.
