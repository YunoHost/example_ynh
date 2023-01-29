#!/usr/bin/env python3
"""
This script is meant to be run by GitHub Actions.
It comes with a Github Action updater.yml to run this script periodically.

Since each app is different, maintainers can adapt its contents to perform
automatic actions when a new upstream release is detected.

You need to enable the action by removing `if ${{ false }}` in updater.yml!
"""

import hashlib
import json
import logging
import os
from subprocess import run, PIPE
import textwrap
from typing import Tuple, Any
import requests
from packaging import version

logging.getLogger().setLevel(logging.INFO)


# ========================================================================== #
# Functions customizable by app maintainer

def get_latest_version(repo: str) -> Tuple[version.Version, Any]:
    """
    May be customized by maintainers for other forges than Github.
    Returns a tuple: a comparable version, and some data that will
    be passed to get_asset_urls_of_release().
    """
    api_url = repo.replace("github.com", "api.github.com/repos")

    # Maintainer: use either releases or tags
    tags = requests.get(f"{api_url}/tags", timeout=3).json()
    tag_info = next(
        tag for tag in tags
        if "-rc" not in tag["name"] and "REL" not in tag["name"]
    )
    return version.Version(tag_info["name"]), tag_info

    # Maintainer: use either releases or tags
    releases = requests.get(f"{api_url}/releases", timeout=3).json()
    release_info = next(
        release for release in releases
        if not release["prerelease"]
    )
    return version.Version(release_info["tag_name"]), release_info


def generate_src_files(repo: str, release: Any):
    """
    Should call write_src_file() for every asset/binary/... to download.
    """

    built_release = f"{repo}/archive/refs/tags/{release['name']}.tar.gz"
    logging.info("Handling main tarball at %s", built_release)
    write_src_file("app.src", built_release, "tar.gz")


# ========================================================================== #
# Core generic code of the script, app maintainers should not edit this part

def sha256sum_of_url(url: str) -> str:
    """Compute checksum without saving the file"""
    checksum = hashlib.sha256()
    for chunk in requests.get(url, stream=True, timeout=1000).iter_content(10*1024):
        checksum.update(chunk)
    return checksum.hexdigest()


def write_src_file(name: str, asset_url: str, extension: str,
                   extract: bool = True, subdir: bool = True) -> None:
    """Rewrite conf/app.src"""
    logging.info("Writing %s...", name)

    with open(f"conf/{name}", "w", encoding="utf-8") as conf_file:
        conf_file.write(textwrap.dedent(f"""\
            SOURCE_URL={asset_url}
            SOURCE_SUM={sha256sum_of_url(asset_url)}
            SOURCE_SUM_PRG=sha256sum
            SOURCE_FORMAT={extension}
            SOURCE_IN_SUBDIR={str(subdir).lower()}
            SOURCE_EXTRACT={str(extract).lower()}
        """))


def write_github_env(proceed: bool, new_version: str, branch: str):
    """Those values will be used later in the workflow"""
    if "GITHUB_ENV" not in os.environ:
        logging.warning("GITHUB_ENV is not in the envvars, assuming not in CI")
        return
    with open(os.environ["GITHUB_ENV"], "w", encoding="utf-8") as github_env:
        github_env.write(textwrap.dedent(f"""\
            VERSION={new_version}
            BRANCH={branch}
            PROCEED={str(proceed).lower()}
        """))


def main():
    with open("manifest.json", "r", encoding="utf-8") as manifest_file:
        manifest = json.load(manifest_file)
    repo = manifest["upstream"]["code"]

    current_version = version.Version(manifest["version"].split("~")[0])
    latest_version, release_info = get_latest_version(repo)
    logging.info("Current version: %s", current_version)
    logging.info("Latest upstream version: %s", latest_version)

    # Proceed only if the retrieved version is greater than the current one
    if latest_version <= current_version:
        logging.warning("No new version available")
        write_github_env(False, "", "")
        return

    # Proceed only if a PR for this new version does not already exist
    branch = f"ci-auto-update-v{latest_version}"
    command = ["git", "ls-remote", "--exit-code", "-h", repo, branch]
    if run(command, stderr=PIPE, stdout=PIPE, check=False).returncode == 0:
        logging.warning("A branch already exists for this update")
        write_github_env(False, "", "")
        return

    generate_src_files(repo, release_info)

    manifest["version"] = f"{latest_version}~ynh1"
    with open("manifest.json", "w", encoding="utf-8") as manifest_file:
        json.dump(manifest, manifest_file, indent=4, ensure_ascii=False)
        manifest_file.write("\n")

    write_github_env(True, latest_version, branch)


if __name__ == "__main__":
    main()
