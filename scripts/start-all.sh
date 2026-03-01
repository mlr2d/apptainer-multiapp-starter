#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
for env_file in services/*/config.env; do
  set -a
  source "$env_file"
  set +a
  apptainer instance start --bind "$DATA_BIND" "services/$SERVICE_NAME/$SERVICE_NAME.sif" "$SERVICE_NAME" "$SERVICE_PORT"
done
