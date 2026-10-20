FROM ghcr.io/haecker-felix/hebbot:v3.0@sha256:7d4719cb15f202cb72be29dda1510417c0e06edf833f039de78b045b313f700d

RUN apt-get update \
    && apt-get install -y --no-install-recommends bash ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh update_config.sh /usr/local/bin/
RUN chmod 0755 /usr/local/bin/entrypoint.sh /usr/local/bin/update_config.sh \
    && mkdir -p /data

WORKDIR /data
ENV CONFIG_PATH=/data/config.toml \
    TEMPLATE_PATH=/data/template.md \
    STORE_PATH=/data/store.json

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["sh", "-c", "RUST_LOG=hebbot=debug hebbot"]
