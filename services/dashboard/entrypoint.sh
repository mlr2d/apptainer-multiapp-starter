#!/usr/bin/env bash
PORT="${1:-${PORT:-8080}}"
cd /opt/app
exec gunicorn --bind "0.0.0.0:${PORT}" --workers "${GUNICORN_WORKERS:-1}" --threads "${GUNICORN_THREADS:-2}" wsgi:app
