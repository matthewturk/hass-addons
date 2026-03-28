# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Install Luanti/Minetest server
# Alpine 3.21 provides 'minetest-server'. Future versions or Edge might provide 'luanti-server'.
# We install 'git' and 'curl' first to ensure they are available for downloading games.
# We include 'sqlite' to manage database locking settings and 'postgresql-client' for DB initialization.
RUN apk add --no-cache git curl sqlite postgresql-client && \
    (apk add --no-cache luanti-server || apk add --no-cache minetest-server || apk add --no-cache luanti || apk add --no-cache minetest)

# Download Minetest Game (classic default)
# We install it to both likely locations to support both Minetest (older Alpine) and Luanti (newer Alpine)
RUN mkdir -p /usr/share/luanti/games /usr/share/minetest/games && \
    git clone --depth 1 https://github.com/minetest/minetest_game.git /usr/share/minetest/games/minetest_game && \
    rm -rf /usr/share/minetest/games/minetest_game/.git && \
    ln -s /usr/share/minetest/games/minetest_game /usr/share/luanti/games/minetest_game

# Copy root filesystem
COPY rootfs /
