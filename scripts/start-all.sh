#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
for env_file in deploy/env/*.env; do
  source "$env_file"
  APPTAINERENV_URL_PREFIX="$URL_PREFIX" \
  APPTAINERENV_GUNICORN_WORKERS="$GUNICORN_WORKERS" \
  APPTAINERENV_GUNICORN_THREADS="$GUNICORN_THREADS" \
  apptainer instance start --bind "$DATA_BIND" "services/$SERVICE_NAME/$SERVICE_NAME.sif" "$SERVICE_NAME" "$SERVICE_PORT"
done
