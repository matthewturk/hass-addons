# Changelog

## 1.0.7

- Add: Added `tzdata` and timezone configuration support.

## 1.0.6

- Update: Replaced logo with game title logo.
- Add: Added schematic screenshot to README.

## 1.0.5

- Update: Changed sidebar icon to `mdi:dragon`.

## 1.0.4

- Fix: Prevent `installer.php` check from triggering reinstall prompt on every restart in container environment.

## 1.0.3

- Fix: Patch `Bootstrap.php` to allow `dbconnect.php` to be outside the root directory (linked).

## 1.0.2

- Fix: Persist `dbconnect.php` in `/data` so it survives updates.

## 1.0.1

- Fix: Ensure `data` directory exists and has correct permissions.
- Fix: Remove default `index.html` to allow `index.php` to serve content.

## 1.0.0

- Initial release of Legend of the Green Dragon (NB-Core) as a Home Assistant add-on.
