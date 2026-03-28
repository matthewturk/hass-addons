# Home Assistant Add-on: Luanti Server

## How to use

### Initial Setup

1. Install the add-on from the Home Assistant add-on store.
2. Configure the desired options in the **Configuration** tab.
3. Start the add-on.
4. Connect with a Luanti client to `<YOUR_HA_IP>:30000` (or the configured port).

### Configuration Options

| Option                 | Description                                                                                                                 |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **Server Name**        | Name shown to players in the server list.                                                                                   |
| **Server Description** | Short description shown in the server list.                                                                                 |
| **Server Port**        | UDP port the server listens on (default: 30000).                                                                            |
| **Maximum Players**    | Maximum simultaneous players (1–100).                                                                                       |
| **Server Password**    | Password required to join. Leave empty for a public server.                                                                 |
| **Enable PvP**         | Allow players to damage each other.                                                                                         |
| **Enable Damage**      | Allow players to take damage and die.                                                                                       |
| **Creative Mode**      | Give players unlimited resources.                                                                                           |
| **Time Speed**         | How fast in-game time passes (72 = 20 real minutes per day). Set to 0 to disable the day/night cycle.                       |
| **Message of the Day** | Displayed to players on join.                                                                                               |
| **World Name**         | Name of the world to load or create (stored in `/data/worlds/`).                                                            |
| **Game ID**            | The game to run (default: `minetest`). Must match a game installed in `/usr/share/luanti/games/` or `/share/luanti/games/`. |
| **Require Password**   | Disallow connections with an empty password.                                                                                |

### Adding Mods

Copy mod directories into `/share/luanti/mods/` using the
Home Assistant **File editor** or **SSH & Web Terminal** add-on.

The server automatically loads all mods found there.

### Adding Games

Copy game directories into `/share/luanti/games/` and set the
**Game ID** option to the game's folder name.

### Persistence

- World data is stored in `/data/worlds/<world_name>/` and persists across restarts.
- The server configuration is regenerated from the add-on options on every start,
  so always use the Home Assistant UI to change settings.

### Port Forwarding

To allow players from outside your local network to connect,
forward UDP port **30000** (or the configured port) on your router to
your Home Assistant IP address.
