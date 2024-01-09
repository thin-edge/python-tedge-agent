#!/bin/bash
set -e
just prepare-up

# Wait for container to startup before doing bootstrapping
just up --build=false >/dev/null 2>&1 &
UP_PID=$!

# Note: bootstrap will wait for the container to be ready
just bootstrap "$DEVICE_ID" </dev/null

# Wait until bootstrap is ready
wait "$UP_PID"
echo "docker compose up is ready"
