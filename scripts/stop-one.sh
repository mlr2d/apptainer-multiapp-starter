#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
source "deploy/env/$1.env"
apptainer instance stop "$SERVICE_NAME"
