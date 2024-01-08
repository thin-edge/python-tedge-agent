#!/bin/bash

just prepare-up

# Wait for container to startup before doing bootstrapping
just up --build=false >/dev/null 2>&1 &
UP_PID=$!

sleep 5
just bootstrap "$DEVICE_ID" </dev/null

# Wait until bootstrap is ready
wait "$UP_PID"
echo "docker compose up is ready"
