# Home Assistant Add-on: ABS Metadata Server

## Overview

This add-on runs [abs_mdserver](https://github.com/matthewturk/abs_mdserver),
a flexible metadata provider for
[Audiobookshelf](https://www.audiobookshelf.org/). It matches book filenames
to records stored in your own JSON or CSV files and serves the results (plus
optional cover images) over HTTP so that Audiobookshelf can use it as a custom
metadata provider.

---

## Configuration options

### `port`

**Default:** `5000`

The TCP port the server listens on **inside** the container. Other
Home Assistant add-ons (such as an Audiobookshelf add-on) can reach the server
at `http://<HA-host-ip>:<port>/search?query={{title}}`.

### `expose_externally`

**Default:** `false`

When set to `true` you should **also** enable port forwarding in the
**Network** tab of this add-on so that devices outside the Home Assistant host
machine (e.g. an Audiobookshelf instance running on a different server) can
reach the metadata server.

When set to `false` (the default) the server is still reachable from every
other add-on that runs on the same Home Assistant instance, which is sufficient
for a co-located Audiobookshelf add-on.

### `metadata_sources`

**Default:** `""`

A path pointing to your metadata file or directory. The path must be located
under `/media` or `/config`. You may supply:

- The path to a **specific** `.json` or `.csv` file.
- The path to a **directory** containing one or more `.json`/`.csv` files
  (only the top level of that directory is scanned).

The server reads these files to match book titles; they are **never modified**.
Any write operations (such as `missing_metadata.json`) are stored exclusively
in the add-on's own `/data` directory.

Example:

```yaml
metadata_sources: /media/audiobooks/metadata/my_collection.csv
```

### `images_dirs`

**Default:** `""`

A directory under `/media` or `/config` that contains cover-image
files (`.png`, `.jpg`, `.jpeg`, `.webp`). Images from this directory
are made available to the server.

Example:

```yaml
images_dirs: /media/audiobooks/covers
```

### `track_missing`

**Default:** `false`

When enabled, every query that returns no metadata match is recorded in
`/data/metadata/missing_metadata.json` as a template entry. This makes it
easy to identify books for which you have not yet provided metadata.

---

## Audiobookshelf integration

1. Open Audiobookshelf **Settings → Metadata Providers**.
2. Click **Add Custom Provider**.
3. Set the **Search URL** to:
   ```
   http://<HA-host-ip>:<port>/search?query={{title}}
   ```
   replacing `<HA-host-ip>` with your Home Assistant machine's IP address and
   `<port>` with the value you configured above.
4. **Save** the provider and enable it in your library settings.

> **Note:** If you see errors in Audiobookshelf logs like `Error: Call to <IP> is blocked` when downloading covers, this is due to Audiobookshelf's Server-Side Request Forgery (SSRF) protection. You may need to configure Audiobookshelf to allow requests to local network addresses (LAN) or your specific add-on IP. Check your Audiobookshelf deployment documentation for environment variables (e.g., `SSRF_FILTER_ALLOW_PRIVATE_IP`) or settings related to local network access.

---

## Security

All filesystem **writes** performed by this add-on are strictly limited to the
add-on's own `/data` directory:

| Path              | Purpose                                                          |
| ----------------- | ---------------------------------------------------------------- |
| `/data/metadata/` | Symlinks to your CSV/JSON source files + `missing_metadata.json` |
| `/data/images/`   | Symlinks to your cover-image files                               |

Source files under `/media` and `/config` are mounted **read-only** and are
never written to. All user-supplied paths are canonicalised with `realpath`
and validated to be under `/media` or `/config` before any symlink is created.
