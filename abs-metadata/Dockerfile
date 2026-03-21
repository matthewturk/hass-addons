# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python 3 and git
RUN apk add --no-cache python3 py3-pip git

# Add a build argument to force cache invalidation for the git clone step
# Change this value to force a rebuild of the subsequent layer
ARG CACHE_BUST=1

# Clone abs_mdserver and install its Python dependencies
RUN git clone --depth 1 https://github.com/matthewturk/abs_mdserver.git /opt/abs_mdserver \
    && pip3 install --no-cache-dir --break-system-packages \
    "Flask==3.1.2"

# Copy root filesystem
COPY rootfs /
