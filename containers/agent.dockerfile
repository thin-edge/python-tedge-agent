ARG PY_VERSION=3.10
FROM python:${PY_VERSION} as builder
WORKDIR /build
RUN python -m pip install build
COPY . .
RUN python -m build --wheel \
    && pip install dist/*.whl

ARG PY_VERSION=3.10
FROM python:${PY_VERSION}-slim
ARG PY_VERSION=3.10

# Copy build artifacts
COPY --from=builder "/usr/local/lib/python${PY_VERSION}/site-packages" "/usr/local/lib/python${PY_VERSION}/site-packages"
COPY --from=builder /usr/local/bin/python-tedge-agent /usr/local/bin/

ENV CONNECTOR_TEDGE_HOST=mqtt-broker
ENV CONNECTOR_TEDGE_API=http://tedge:8000

CMD ["python-tedge-agent"]