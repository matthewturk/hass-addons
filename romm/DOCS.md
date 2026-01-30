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
  - This is where you should place your ROM files
  - Must be accessible from Home Assistant (use `/share/`, `/media/`, or `/config/`)
  
- **assets_path**: Path to store assets like saves and states (default: `/share/romm/assets`)
  - RomM will store uploaded saves, states, and other user data here
  
- **auth_secret_key**: Secret key for authentication (leave empty to auto-generate)
  - Used to encrypt authentication tokens
  - If you don't provide one, a random key will be generated on each start
  - For persistence, generate one with: `openssl rand -hex 32`

### External Database (Optional)

For better performance with large libraries, you can use an external MariaDB/MySQL database:

- **db_host**: Hostname or IP of your database server (e.g., `192.168.1.100` or `core-mariadb`)
- **db_name**: Database name (default: `romm`)
- **db_user**: Database username (default: `romm-user`)
- **db_passwd**: Database password

**Note**: If you don't configure an external database, RomM will use SQLite which is stored in the addon's data directory.

#### Setting up MariaDB

If you want to use the MariaDB add-on:

1. Install the official "MariaDB" add-on from the Home Assistant add-on store
2. Create a database for RomM:
   ```sql
   CREATE DATABASE romm;
   CREATE USER 'romm-user'@'%' IDENTIFIED BY 'your-secure-password';
   GRANT ALL PRIVILEGES ON romm.* TO 'romm-user'@'%';
   FLUSH PRIVILEGES;
   ```
3. Configure RomM with:
   - db_host: `core-mariadb`
   - db_name: `romm`
   - db_user: `romm-user`
   - db_passwd: `your-secure-password`

### Metadata Providers (Optional)

Configure API keys for metadata providers to enhance your library:

- **screenscraper_user**: ScreenScraper username
  - Register at https://www.screenscraper.fr/
  
- **screenscraper_password**: ScreenScraper password
  
- **retroachievements_api_key**: RetroAchievements API key
  - Get your key from https://retroachievements.org/
  
- **steamgriddb_api_key**: SteamGridDB API key
  - Get your key from https://www.steamgriddb.com/
  
- **hasheous_api_enabled**: Enable Hasheous metadata provider (default: true)
  - No API key required

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

**Important**: The folder names should match the platform names that RomM recognizes. RomM will automatically detect platforms based on folder names.

For detailed folder structure guidelines, see: https://docs.romm.app/latest/Getting-Started/Folder-Structure/

## Usage

1. After starting the add-on, access the web interface at `http://homeassistant.local:8080`
2. Create an admin account on first launch
3. Add your ROMs to the library path
4. Scan your library from the web interface
5. Enjoy your organized ROM collection!

## Known Limitations

- **Ingress**: This add-on does not currently support Home Assistant ingress. You must access it via the direct port (8080).
- **Redis**: Redis is managed internally by the add-on. External Redis configuration is not currently supported.

## Technical Notes

### Frontend Development Mode

This add-on runs RomM using its official Docker image, which runs the frontend with `npm run dev` (development mode). This is **intentional and by design** from the RomM developers - the official Docker image uses dev mode even in production deployments.

**Why this is not a problem:**
- This is the official, supported way to run RomM in Docker
- All features work correctly in dev mode
- Development mode features (hot reload, verbose logging) are not problematic in self-hosted environments
- The RomM project has chosen this approach for their official distribution

If you have concerns about this, please refer to the [RomM project's documentation](https://docs.romm.app/) and their [official Docker image](https://hub.docker.com/r/rommapp/romm).

## Troubleshooting

### Cannot access the web interface
- Make sure port 8080 is not already in use by another service
- Check the add-on logs for any errors
- Verify that the add-on is running

### ROMs not detected
- Check that your ROM files are in the correct folder structure
- Make sure the paths are correctly configured in the add-on settings
- Verify that the add-on has read/write access to the library path
- Try refreshing/rescanning your library from the web interface

### Database connection errors
- If using an external database, verify the connection details
- Check that the database server is running and accessible
- Verify that the database user has the correct permissions

## Support

For more information about RomM:
- Documentation: https://docs.romm.app/
- GitHub: https://github.com/rommapp/romm
- Home: https://romm.app/

For issues specific to this Home Assistant add-on:
- GitHub Issues: https://github.com/matthewturk/hass-romm/issues
