# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python 3 and git
RUN apk add --no-cache python3 py3-pip git

# Clone abs_mdserver and install its Python dependencies
RUN git clone --depth 1 https://github.com/matthewturk/abs_mdserver.git /opt/abs_mdserver \
    && pip3 install --no-cache-dir --break-system-packages \
        "Flask==3.1.2"

# Copy root filesystem
COPY rootfs /
