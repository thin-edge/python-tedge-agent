#!/bin/bash
set -e
just prepare-up

# Wait for container to startup before doing bootstrapping
just up --build=false >/dev/null 2>&1 &
UP_PID=$!

# Wait for bootstrap service to 
COUNTER=1
TIMEOUT=60
BOOTSTRAP=1
if [ "$(docker compose ps tedge -a --format '{{.State}}')" != "running" ]; then
    while [ "$(docker compose ps bootstrap -a --format '{{.State}}')" != "running" ]; do
        if [ "$COUNTER" -ge "$TIMEOUT" ]; then
            echo "Timed out waiting for bootstrap service to be ready" >&2
            exit 1
        fi
        echo "bootstrap service not running...attempt $COUNTER" >&2
        sleep 1
        COUNTER=$((COUNTER + 1))
    done
else
    echo "tedge service is already running (bootstrapping was probably already done)" >&2
    BOOTSTRAP=0
fi

if [ "$BOOTSTRAP" = 1 ]; then
    just bootstrap "$DEVICE_ID" </dev/null
fi

# Wait until bootstrap is ready
wait "$UP_PID"
echo "docker compose up is ready"
