#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
source ./config.env
apptainer build "$SERVICE_NAME.sif" Apptainer.def
