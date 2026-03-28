# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
# Use romm's official image as base
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Re-declare build args after FROM
ARG S6_OVERLAY_VERSION
ARG BASHIO_VERSION

# Install dependencies for the build/init (not already in base)
RUN apk add --no-cache \
    xz \
    jq \
    && ln -sf /bin/bash /usr/bin/bash

# Preserve the original RomM init script (bash) before s6-overlay overwrites it
RUN mv /init /usr/bin/romm-init && chmod +x /usr/bin/romm-init

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install s6-overlay for Home Assistant add-on support
RUN case "$(uname -m)" in \
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

# Create symlinks for s6-overlay commands to maintain compatibility with HA scripts
RUN if [ -d /command ]; then \
    ln -s /command/with-contenv /usr/bin/with-contenv; \
    ln -s /command/s6-env /usr/bin/s6-env; \
    ln -s /command/s6-echo /usr/bin/s6-echo; \
    ln -s /command/s6-halt /usr/bin/s6-halt; \
    fi

# Install bashio for Home Assistant add-on integration
RUN curl -sSL -o /tmp/bashio.tar.gz \
    "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
    && mkdir -p /tmp/bashio \
    && tar zxvf /tmp/bashio.tar.gz --strip 1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && chmod a+x /usr/bin/bashio \
    && rm -rf /tmp/*

# Setup persistent config
COPY rootfs /

# Make scripts executable
RUN chmod a+x /etc/services.d/romm/run \
    && chmod a+x /etc/services.d/romm/finish

# Use s6-overlay as the init system
ENTRYPOINT ["/init"]
