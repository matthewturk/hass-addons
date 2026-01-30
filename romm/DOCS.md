# Home Assistant Add-on: RomM

## About

RomM (ROM Manager) is a beautiful, powerful, self-hosted ROM management solution for organizing and managing your retro gaming library.

## Features

- **ROM Library Management**: Organize your ROM collection with a beautiful web interface
- **Metadata Integration**: Automatically fetch metadata from multiple sources (ScreenScraper, RetroAchievements, SteamGridDB, Hasheous)
- **Multi-Platform Support**: Support for numerous gaming platforms and emulators
- **Cover Art & Screenshots**: Automatically download and display cover art and screenshots
- **Web Interface**: Modern, responsive web UI accessible from any device
- **Database Support**: MariaDB/MySQL or PostgreSQL required (MariaDB add-on recommended)

## Installation

### Prerequisites

**RomM requires a database.** The simplest way to provide this is by using the official Home Assistant **MariaDB add-on**.

1. Install the **MariaDB add-on** from the Add-on Store.
2. In the MariaDB add-on configuration, add a database for RomM:
   ```yaml
   databases:
     - romm
   logins:
     - database: romm
       password: your-secure-password
       username: romm-user
   ```
3. Start the MariaDB add-on.

### From Repository (Remote)

1. Add this repository to your Home Assistant add-on store: `https://github.com/matthewturk/hass-romm`
2. Install the "RomM" add-on.
3. In the RomM add-on **Configuration** tab:
   - If using the MariaDB add-on, the settings are optional as RomM will try to detect it automatically. For reliability, it is recommended to set:
     - `db_host`: `core-mariadb`
     - `db_name`: `romm`
     - `db_user`: `romm-user`
     - `db_passwd`: `your-secure-password`
4. Start the add-on.
5. Access RomM via the "Open Web UI" button or on port 8080

### Local Deployment (Manual)

If you want to deploy this add-on locally without using a remote GitHub repository:

1. Enable the **Samba share** or **SSH** add-on in Home Assistant to access your HA file system.
2. Create a folder named `romm` inside the `/addons` directory of your Home Assistant installation.
3. Copy all files from this repository's `romm/` folder (including `Dockerfile`, `config.yaml`, and the `rootfs` directory) into that new `/addons/romm/` directory.
4. In the Home Assistant UI, go to **Settings** > **Add-ons** > **Add-on Store**.
5. Click the three-dot menu in the upper right and select **Check for updates**.
6. A new section called **Local Add-ons** will appear at the top. Find "RomM" and click **Install**.

## Configuration

### Basic Configuration

The add-on requires minimal configuration to get started. At minimum, you should:

1. Set an authentication secret key (or one will be generated automatically)
2. Configure where your ROM library and assets will be stored

### Network and Ports

By default, the add-on is accessible via **Ingress** (the "Open Web UI" button in the Home Assistant sidebar).

If you want to access RomM directly via a port:

1. Go to the **Network** tab in the add-on settings.
2. Under the **8080/tcp** entry, you can change the host port from `8080` to any other available port (e.g., `8888`).
3. Click **Save** and restart the add-on.

### SSL Configuration

You can use your system-wide SSL certificates (e.g., from Let's Encrypt) with RomM:

1. Ensure your certificates are in the `/ssl` directory of your Home Assistant installation.
2. In the add-on configuration, set `ssl` to `true`.
3. Specify your `certfile` (default: `fullchain.pem`) and `keyfile` (default: `privkey.pem`).
4. RomM will now be accessible via HTTPS on the configured port.

**Note**: If you access RomM via **Ingress**, Home Assistant handles SSL automatically, and you do not need to enable this setting.

### Configuration Options

- **library_path**: Path to your ROM library (default: `/share/romm/library`)
  - This is where you should place your ROM files
  - **Supported paths**: `/share/`, `/media/`, or `/config/` (with any subpath)
  - **Examples**:
    - `/share/romm/library` (default)
    - `/media/usb_drive/roms` (external drive)
    - `/media/network_share/games` (network storage)
    - `/config/roms` (config directory)
- **assets_path**: Path to store assets like saves and states (default: `/share/romm/assets`)
  - RomM will store uploaded saves, states, and other user data here
  - **Supported paths**: `/share/`, `/media/`, or `/config/` (with any subpath)
  - Can be on a different mount than library_path
- **config_path**: Path to the RomM configuration file (default: `/share/romm/config.yml`)
  - This allows you to edit advanced RomM settings (like netplay, controller mapping) directly in a YAML file
  - **Supported paths**: `/share/`, `/media/`, or `/config/` (with any subpath)
  - You can use `/config/romm/config.yml` to make it editable via the Home Assistant File Editor add-on.
- **auth_secret_key**: Secret key for authentication (leave empty to auto-generate)
  - Used to encrypt authentication tokens
  - If you don't provide one, a random key will be generated on each start
  - For persistence, generate one with: `openssl rand -hex 32`

### Database Configuration

RomM requires an external MariaDB/MySQL or PostgreSQL database. SQLite is not supported in recent versions of RomM.

The easiest way to set this up is using the Home Assistant **MariaDB add-on**:

1. Install the "MariaDB" add-on.
2. Configure it with a database and user (see Prerequisites section).
3. Set the following in RomM configuration:
   - **db_host**: `core-mariadb`
   - **db_name**: `romm`
   - **db_user**: `romm-user`
   - **db_passwd**: your chosen password

Alternatively, you can use any external MySQL/MariaDB server:

- **db_host**: Hostname or IP of your database server (e.g., `192.168.1.100`)
- **db_name**: Database name (default: `romm`)
- **db_user**: Database username (default: `romm-user`)
- **db_passwd**: Database password

#### Setting up MariaDB (Manual External Server)

If you are NOT using the HASS add-on but a separate server:

```sql
CREATE DATABASE romm;
CREATE USER 'romm-user'@'%' IDENTIFIED BY 'your-secure-password';
GRANT ALL PRIVILEGES ON romm.* TO 'romm-user'@'%';
FLUSH PRIVILEGES;
```

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
<your_configured_path>/
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

**Examples of library_path configurations:**

- Default: `/share/romm/library/`
- External USB drive: `/media/usb_drive/roms/`
- Network share: `/media/nas/gaming/roms/`
- Config directory: `/config/roms/`

**Important**: The folder names should match the platform names that RomM recognizes. RomM will automatically detect platforms based on folder names.

For detailed folder structure guidelines, see: https://docs.romm.app/latest/Getting-Started/Folder-Structure/

## Using External Storage

The add-on supports storing ROMs on external drives or network shares via the `/media` mount point.

### Setting up External Storage

1. **Mount your storage in Home Assistant**
   - USB drives, external hard drives, and network shares should be mounted to `/media`
   - Home Assistant automatically mounts USB drives under `/media/`
   - For network shares (NFS/SMB), configure them in Home Assistant's configuration

2. **Configure library_path**
   - Set `library_path` to point to your media location
   - Example: `/media/usb_drive/roms` or `/media/nas_share/gaming/roms`
   - The add-on will create the directory if it doesn't exist

3. **Verify access**
   - Check the add-on logs to ensure the path is accessible
   - The startup script will create directories and symlink them to RomM's expected paths

**Benefits of using /media:**

- Store large ROM collections on external drives
- Use network-attached storage (NAS) for centralized ROM management
- Separate ROM storage from Home Assistant's main storage

## Usage

1. After starting the add-on, access the web interface at `http://homeassistant.local:8080`
2. Create an admin account on first launch
3. Add your ROMs to the library path
4. Scan your library from the web interface
5. Enjoy your organized ROM collection!

## Known Limitations

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
