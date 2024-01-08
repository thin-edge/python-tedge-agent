set dotenv-load

# Install dev dependencies
install-deps:
    pip3 install .[dev]

# Format python code
format:
    python3 -m black src

# Check formatting
format-check:
    python3 -m black --check src

# Run linter
lint:
    python3 -m pylint src

# Prepare up but don't start any containers
prepare-up *args='':
    docker compose build {{args}}

# Run demo
up *args="":
    docker compose up --detach --build {{args}}

# Setup and bootstrap
up-ci:
    ./ci/demo.sh

# Stop demo
down:
    docker compose down

# Stop demo and delete any volumes
down-all:
    docker compose down -v

# Configure and register the device to the cloud (requires go-c8y-cli and c8y-tedge extension)
bootstrap *args="":
    c8y tedge bootstrap-container bootstrap "$DEVICE_ID" {{args}}

# Install python virtual environment
venv:
  [ -d .venv ] || python3 -m venv .venv
  ./.venv/bin/pip3 install -r tests/requirements.txt

# Run tests
test *ARGS='':
  ./.venv/bin/python3 -m robot.run --outputdir output {{ARGS}} tests

# Cleanup device and all it's dependencies
cleanup DEVICE_ID $CI="true":
    echo "Removing device and child devices (including certificates)"
    c8y devicemanagement certificates list -n --tenant "$(c8y currenttenant get --select name --output csv)" --filter "name eq {{DEVICE_ID}}" --pageSize 2000 | c8y devicemanagement certificates delete --tenant "$(c8y currenttenant get --select name --output csv)"
    c8y inventory find -n --owner "device_{{DEVICE_ID}}" -p 100 | c8y inventory delete
    c8y users delete -n --id "device_{{DEVICE_ID}}" --tenant "$(c8y currenttenant get --select name --output csv)" --silentStatusCodes 404 --silentExit
