#!/usr/bin/env python3
"""
This script is meant to be run by GitHub Actions.
It comes with a Github Action updater.yml to run this script periodically.
You need to enable the action by removing `if ${{ false }}` in updater.yml!
"""

from typing import Tuple, Any
import requests
from packaging import version
import updater_lib as lib


def get_latest_version(repo: str) -> Tuple[version.Version, Any]:
    """
    May be customized by maintainers for other forges than Github.
    Returns a tuple:
    - a comparable version
    - some data that will be passed to get_asset_urls_of_release().

    This example handles tags on github.
    """
    api_url = repo.replace("github.com", "api.github.com/repos")

    tags = requests.get(f"{api_url}/tags", timeout=3).json()
    tag_info = next(
        tag for tag in tags
        if "-rc" not in tag["name"] and "REL" not in tag["name"]
    )
    return version.Version(tag_info["name"]), tag_info


def get_latest_version_releases(repo: str) -> Tuple[version.Version, Any]:
    """
    Another example of get_latest_version that handles github releases
    """
    api_url = repo.replace("github.com", "api.github.com/repos")

    releases = requests.get(f"{api_url}/releases", timeout=3).json()
    release_info = next(
        release for release in releases
        if not release["prerelease"]
    )
    return version.Version(release_info["tag_name"]), release_info


def generate_src_files(repo: str, release: Any):
    """
    You should call write_src_file() for every asset/binary/... to download.
    It will handle downloading and computing of the sha256.
    """

    built_release = f"{repo}/archive/refs/tags/{release['name']}.tar.gz"
    lib.write_src_file("app.src", built_release, "tar.gz")


if __name__ == "__main__":
    lib.run(get_latest_version, generate_src_files)
