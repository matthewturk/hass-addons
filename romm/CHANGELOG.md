<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

## 1.2.9

- Fixed `ROMM_AUTH_SECRET_KEY` generation logic
- Implemented automatic 32-byte hex key generation if none is provided
- Optimized startup command to correctly trigger RomM backend through entrypoint script

## 1.2.8

- Added full entrypoint inspection
- Implemented heuristic command execution for RomM backend

## 1.2.7

- Added entrypoint inspection for debugging loop issues
- Improved service execution flow

## 1.2.6

- Fixed entrypoint detection by adding `/docker-entrypoint.sh` support
- Cleaned up startup discovery logs

## 1.2.5

- Added root directory discovery to find RomM entrypoint
- Added dynamic entrypoint detection
- Improved error reporting during startup

## 1.2.4

- Improved RomM entrypoint detection
- Added fallback for manual service start
- Added debugging logs for startup troubleshooting

## 1.2.3

- Removed risky path manipulations that caused permission errors
- Switched completely to environment variables for path mapping
- Added extra logging for path configuration

## 1.2.2

- Fixed path mapping permission denied errors by using environment variables
- Improved `s6-overlay` binary compatibility
- Cleaned up `finish` script to use `bashio` exit handlers

## 1.2.1

- Fixed `bashio` installation path and binary location
- Added `bash` symlink for better script compatibility
- Improved Dockerfile robustness for non-HASS base images

## 1.2.0

- Fixed Dockerfile issues (Alpine `apk` and dependency fixes)
- Fixed `s6-overlay` execution errors
- Added SSL support using `/ssl` mount
- Improved `bashio` installation logic

## 1.1.0

- Added Home Assistant Ingress support
- Added support for configurable host ports
- Updated documentation with local deployment instructions

## 1.0.0

- Initial release of RomM add-on
- Support for aarch64 and amd64 architectures
- Web interface on port 8080
- SQLite and external MariaDB/MySQL database support
- Metadata provider integration (ScreenScraper, RetroAchievements, SteamGridDB, Hasheous)
- Configurable library and assets paths
- AppArmor security profile
