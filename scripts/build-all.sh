#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
for env_file in deploy/env/*.env; do
  source "$env_file"
  cd "services/$SERVICE_NAME"
  apptainer build "$SERVICE_NAME.sif" Apptainer.def
  cd - >/dev/null
done
