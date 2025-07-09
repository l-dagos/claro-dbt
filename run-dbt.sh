#!/usr/bin/env bash
set -o allexport
source "$(dirname "$0")/.env"
set +o allexport

uv run dbt "$@"
