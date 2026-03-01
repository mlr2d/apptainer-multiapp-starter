#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
printf '%-12s %-10s %-8s %-12s %s\n' "SERVICE" "INSTANCE" "PORT" "PREFIX" "IMAGE"
for env_file in services/*/config.env; do
  source "$env_file"
  PREFIX="${APPTAINERENV_URL_PREFIX:-${URL_PREFIX:-/}}"
  printf '%-12s %-10s %-8s %-12s %s\n' "$SERVICE_NAME" "$SERVICE_NAME" "$SERVICE_PORT" "$PREFIX" "services/$SERVICE_NAME/$SERVICE_NAME.sif"
done
echo
apptainer instance list
