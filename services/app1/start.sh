#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
set -a
source ./config.env
set +a
apptainer instance start --bind "$DATA_BIND" "$SERVICE_NAME.sif" "$SERVICE_NAME" "$SERVICE_PORT"
