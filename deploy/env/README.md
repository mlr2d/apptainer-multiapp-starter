# Environment Configuration

Each file in this folder (`*.env`) describes one service runtime configuration.

## Required keys
- `SERVICE_NAME` (example: `app1`)
- `SERVICE_PORT` (example: `8071`)
- `URL_PREFIX` (example: `/app1`)
- `GUNICORN_WORKERS` (example: `1`)
- `GUNICORN_THREADS` (example: `2`)

## How scripts use these values
Scripts in `/scripts` assume:
- image path: `services/$SERVICE_NAME/$SERVICE_NAME.sif`
- instance name: `$SERVICE_NAME`

Runtime injection:
- `URL_PREFIX` -> `APPTAINERENV_URL_PREFIX`
- `GUNICORN_WORKERS` -> `APPTAINERENV_GUNICORN_WORKERS`
- `GUNICORN_THREADS` -> `APPTAINERENV_GUNICORN_THREADS`
- `SERVICE_PORT` is passed as the container start argument.

Keep `SERVICE_NAME` aligned with folder/image naming to avoid script changes.
