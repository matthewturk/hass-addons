#!/usr/bin/env python3
"""
Entry point for the ABS Metadata Server add-on.

Reads configuration from /data/options.json and starts the metadata server.
All filesystem writes are limited to /data/metadata (the add-on's own data directory).
"""
import sys
import os
import json
import argparse

# Add abs_mdserver source to the Python path
sys.path.insert(0, "/opt/abs_mdserver")

from src.metadata_provider.core.loader import MetadataLoader
from src.metadata_provider.core.matcher import MetadataMatcher
from src.metadata_provider.server import create_app


def load_options():
    """Load configuration from the Home Assistant options file."""
    options_file = "/data/options.json"
    with open(options_file) as f:
        return json.load(f)


def main():
    parser = argparse.ArgumentParser(
        description="ABS Metadata Server for Home Assistant"
    )
    parser.add_argument("--port", type=int, default=5000)
    parser.add_argument("--metadata-dir", default="/data/metadata")
    parser.add_argument("--images-dir", default="/data/images")
    parser.add_argument("--track-missing", action="store_true")
    args = parser.parse_args()

    loader = MetadataLoader(args.metadata_dir, args.images_dir)
    loader.index_images()
    loader.load_all_metadata()

    matcher = MetadataMatcher(loader)
    app = create_app(loader, matcher, track_missing=args.track_missing)

    # Always bind to 0.0.0.0 so other add-ons on the HA internal Docker network
    # (e.g. Audiobookshelf) can reach this server.  External (host-network)
    # exposure is controlled separately via the port-forwarding setting in the
    # Home Assistant Network tab of this add-on.
    app.run(host="0.0.0.0", port=args.port)


if __name__ == "__main__":
    main()
