ARG SOURCE_IMAGE="bluefin"
ARG SOURCE_SUFFIX="-dx"
ARG SOURCE_TAG="41"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

COPY build.sh /tmp/build.sh

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

COPY --from=ghcr.io/blue-build/modules/bling:latest /modules/bling/installers/1password.sh /tmp/1password.sh
RUN chmod +x /tmp/1password.sh && \
    /tmp/1password.sh && \
    ostree container commit
