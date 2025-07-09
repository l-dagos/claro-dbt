#!/usr/bin/env bash
set -o allexport
source "$(dirname "$0")/.env"
set +o allexport

# como el directorio del proyecto está en dbt/demo
cd "$(dirname "$0")/demo"

uv run dbt "$@"
