# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
# Use romm's official image as base
ARG BUILD_FROM
FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install s6-overlay for Home Assistant add-on support
ARG S6_OVERLAY_VERSION="3.1.6.2"
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        xz-utils \
        redis-server \
    && case "$(uname -m)" in \
        x86_64) S6_ARCH="x86_64" ;; \
        aarch64) S6_ARCH="aarch64" ;; \
        *) echo "Unsupported architecture" && exit 1 ;; \
    esac \
    && curl -sSL -o /tmp/s6-overlay-noarch.tar.xz \
        "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz" \
    && curl -sSL -o /tmp/s6-overlay.tar.xz \
        "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}.tar.xz" \
    && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay.tar.xz \
    && rm /tmp/s6-overlay*.tar.xz

# Install bashio for Home Assistant add-on integration
ARG BASHIO_VERSION="0.16.2"
RUN curl -sSL -o /tmp/bashio.tar.gz \
        "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
    && mkdir -p /tmp/bashio \
    && tar zxf /tmp/bashio.tar.gz --strip 1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy root filesystem (including s6 service scripts)
COPY rootfs /

# Make scripts executable
RUN chmod a+x /etc/services.d/romm/run \
    && chmod a+x /etc/services.d/romm/finish

# Use s6-overlay as the init system
ENTRYPOINT ["/init"]
