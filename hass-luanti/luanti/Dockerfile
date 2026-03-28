# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Install Luanti/Minetest server
# Alpine 3.21+ uses the 'luanti' package (renamed from minetest)
# Falls back to 'minetest' for older Alpine base images
RUN apk add --no-cache luanti || apk add --no-cache minetest

# Copy root filesystem
COPY rootfs /
