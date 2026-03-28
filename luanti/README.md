# Home Assistant Add-on: Luanti Server

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

A Home Assistant add-on that hosts a [Luanti](https://www.luanti.org/) (formerly Minetest)
game server, configurable entirely from the Home Assistant UI.

## About

Luanti is a free, open-source voxel game engine with easy modding and game creation.
This add-on runs a dedicated Luanti server so you can host your own game world
directly from Home Assistant.

## Features

- Exposes all key server settings in the Home Assistant UI
- Persistent world storage in the add-on `/data` directory
- Mod and game support via the `/share/luanti/` directory
- Compatible with standard Luanti/Minetest clients

## Installation

1. Add this repository to your Home Assistant add-on store.
2. Install the **Luanti Server** add-on from this repository.
3. Configure the server options in the add-on configuration tab.
4. Start the add-on.
5. Connect with your Luanti client to `<HA_IP>:30000`.

## Adding Mods and Games

Place mods in `/share/luanti/mods/` and games in `/share/luanti/games/`
using the Home Assistant File editor or SSH add-on.
They will be automatically loaded by the server.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
