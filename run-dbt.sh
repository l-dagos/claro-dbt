#!/usr/bin/env bash

# como el directorio del proyecto está en dbt/demo
cd "$(dirname "$0")/demo"

uv run dbt "$@"
