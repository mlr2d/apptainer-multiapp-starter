#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
source ./config.env
apptainer instance stop "$SERVICE_NAME"
