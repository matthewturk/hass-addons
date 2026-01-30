# Home Assistant Add-on: RomM

## About

RomM (ROM Manager) is a beautiful, powerful, self-hosted ROM management solution for organizing and managing your retro gaming library.

## Features

- **ROM Library Management**: Organize your ROM collection with a beautiful web interface
- **Metadata Integration**: Automatically fetch metadata from multiple sources (ScreenScraper, RetroAchievements, SteamGridDB, Hasheous)
- **Multi-Platform Support**: Support for numerous gaming platforms and emulators
- **Cover Art & Screenshots**: Automatically download and display cover art and screenshots
- **Web Interface**: Modern, responsive web UI accessible from any device
- **Database Support**: Use SQLite (built-in) or external MariaDB/MySQL database

## Installation

1. Add this repository to your Home Assistant add-on store
2. Install the "RomM" add-on
3. Configure the add-on (see Configuration section below)
4. Start the add-on
5. Access RomM via the web UI on port 8080

## Configuration

### Basic Configuration

The add-on requires minimal configuration to get started. At minimum, you should:

1. Set an authentication secret key (or one will be generated automatically)
2. Configure where your ROM library and assets will be stored

### Configuration Options

- **library_path**: Path to your ROM library (default: `/share/romm/library`)
- **assets_path**: Path to store assets like saves and states (default: `/share/romm/assets`)
- **auth_secret_key**: Secret key for authentication (leave empty to auto-generate)

### External Database (Optional)

For better performance with large libraries, you can use an external MariaDB/MySQL database:

- **db_host**: Hostname or IP of your database server
- **db_name**: Database name (default: `romm`)
- **db_user**: Database username (default: `romm-user`)
- **db_passwd**: Database password

### Metadata Providers (Optional)

Configure API keys for metadata providers to enhance your library:

- **screenscraper_user**: ScreenScraper username
- **screenscraper_password**: ScreenScraper password
- **retroachievements_api_key**: RetroAchievements API key
- **steamgriddb_api_key**: SteamGridDB API key
- **hasheous_api_enabled**: Enable Hasheous metadata provider (default: true)

For more information on metadata providers, see: https://docs.romm.app/latest/Getting-Started/Metadata-Providers/

## ROM Library Structure

Place your ROMs in the configured library path following this structure:

```
/share/romm/library/
├── Nintendo - Nintendo Entertainment System/
│   ├── Game1.nes
│   └── Game2.nes
├── Nintendo - Super Nintendo Entertainment System/
│   ├── Game1.sfc
│   └── Game2.sfc
└── Sony - PlayStation/
    ├── Game1.bin
    └── Game2.iso
```

For detailed folder structure guidelines, see: https://docs.romm.app/latest/Getting-Started/Folder-Structure/

## Usage

1. After starting the add-on, access the web interface at `http://homeassistant.local:8080`
2. Create an admin account on first launch
3. Add your ROMs to the library path
4. Scan your library from the web interface
5. Enjoy your organized ROM collection!

## Support

For more information about RomM:
- Documentation: https://docs.romm.app/
- GitHub: https://github.com/rommapp/romm
- Home: https://romm.app/
