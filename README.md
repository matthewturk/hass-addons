# RomM Home Assistant Add-on

This repository provides a Home Assistant add-on for RomM (ROM Manager), a beautiful, powerful, self-hosted ROM management solution.

Add-on documentation: <https://developers.home-assistant.io/docs/add-ons>

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmatthewturk%2Fhass-romm)

## About RomM

RomM is a web-based ROM manager that helps you organize and manage your retro gaming library. It features:

- Beautiful, modern web interface
- Automatic metadata fetching from multiple sources
- Support for numerous gaming platforms
- Cover art and screenshot management
- Multi-platform support (works on various architectures)

## Add-ons

This repository contains the following add-on:

### [RomM](./romm)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_ROM Manager - A beautiful, powerful, self-hosted ROM management solution._

## Installation

### Standard Installation

1. Click the button above or manually add this repository URL to your Home Assistant add-on store: `https://github.com/matthewturk/hass-romm`
2. Install the "RomM" add-on
3. Configure the add-on settings
4. Start the add-on
5. Access RomM via the "Open Web UI" button or on port 8080

### Local Deployment (No Remote Repo)

To deploy this add-on locally without using GitHub:

1. Copy the `romm` folder from this repository into the `/addons` directory of your Home Assistant installation.
2. Go to **Settings** > **Add-ons** > **Add-on Store** in Home Assistant.
3. Click the menu (three dots) in the top right and select **Check for updates**.
4. Install "RomM" from the **Local add-ons** section.

## Configuration

The add-on can be configured through the Home Assistant UI. Key configuration options include:

- **ROM Library Path**: Where your ROM files are stored
- **Assets Path**: Where saves, states, and other assets are stored
- **Network Port**: By default, it uses port 8080. You can change this in the **Network** tab of the add-on settings if you want to use a different port for direct access.
- **Database Settings**: Optional external database configuration
- **API Keys**: Optional metadata provider API keys for enhanced functionality

For detailed configuration instructions, see the [add-on documentation](./romm/DOCS.md).

## Support

- RomM Documentation: <https://docs.romm.app/>
- RomM GitHub: <https://github.com/rommapp/romm>
- RomM Website: <https://romm.app/>

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
