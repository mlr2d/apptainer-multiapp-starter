# Apps Dashboard Apptainer Template

Multi-service Apptainer template aligned with the `apps-dashboard` folder layout.

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
    │   ├── app/
    │   ├── Apptainer.def
    │   ├── build.sh
    │   ├── config.env
    │   ├── start.sh
    │   ├── stop.sh
    │   └── wsgi.py
    └── app2
        ├── app/
        ├── Apptainer.def
        ├── build.sh
        ├── config.env
        ├── start.sh
        ├── stop.sh
        └── wsgi.py
```

## Service config model
Each service owns its runtime config at `services/<service>/config.env`.

Required keys:
- `SERVICE_NAME`
- `SERVICE_PORT`
- `APPTAINERENV_URL_PREFIX`
- `DATA_BIND` (`host_path:container_path`)
- `APPTAINERENV_GUNICORN_WORKERS`
- `APPTAINERENV_GUNICORN_THREADS`

## Run
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

Run one service:
```bash
./services/app1/start.sh
```

Stop one service:
```bash
./services/app1/stop.sh
```

## Notes
- Scripts discover services via `services/*/config.env`.
- `Apptainer.def` files are generic; runtime values come from `config.env`.
- Data mounts are passed through `DATA_BIND`.
