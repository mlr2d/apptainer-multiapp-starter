#!/usr/bin/env bash
set -euo pipefail
[[ $# -eq 1 ]] || { echo "Usage: $0 <service>"; exit 1; }
cd "$(dirname "$0")/.."
source "deploy/env/$1.env"
APPTAINERENV_URL_PREFIX="$URL_PREFIX" \
APPTAINERENV_GUNICORN_WORKERS="$GUNICORN_WORKERS" \
APPTAINERENV_GUNICORN_THREADS="$GUNICORN_THREADS" \
apptainer instance start --bind "$DATA_BIND" "services/$SERVICE_NAME/$SERVICE_NAME.sif" "$SERVICE_NAME" "$SERVICE_PORT"
