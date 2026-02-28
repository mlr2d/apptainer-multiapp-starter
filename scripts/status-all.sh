#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
printf '%-12s %-10s %-8s %-12s %s\n' "SERVICE" "INSTANCE" "PORT" "PREFIX" "IMAGE"
for env_file in deploy/env/*.env; do
  source "$env_file"
  printf '%-12s %-10s %-8s %-12s %s\n' "$SERVICE_NAME" "$SERVICE_NAME" "$SERVICE_PORT" "$URL_PREFIX" "services/$SERVICE_NAME/$SERVICE_NAME.sif"
done
echo
apptainer instance list
