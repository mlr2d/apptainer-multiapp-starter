# Environment Config

Each `*.env` file defines one service.

## Required keys
- `SERVICE_NAME` (example: `app1`)
- `SERVICE_PORT` (example: `8071`)
- `URL_PREFIX` (example: `/app1`)
- `GUNICORN_WORKERS` (example: `1`)
- `GUNICORN_THREADS` (example: `2`)

## Naming convention used by scripts
From `SERVICE_NAME`, scripts assume:
- image path: `services/$SERVICE_NAME/$SERVICE_NAME.sif`
- instance name: `$SERVICE_NAME`

Keep `SERVICE_NAME` aligned with your folder and image names.

These files are consumed by scripts in `/scripts`.
