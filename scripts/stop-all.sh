#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
for env_file in deploy/env/*.env; do
  source "$env_file"
  apptainer instance stop "$SERVICE_NAME" || true
done
