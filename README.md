# Usage of this package (REMOVE THIS SECTION BEFORE RELEASE)
- Copy this app before working on it.
- Edit `conf/nginx.conf` file to match application prerequisites.
- Edit `manifest.json` with application specific information.
- Edit the `install`, `upgrade`, `remove`, `backup`, and `restore` scripts.
  - Using the [script helpers documentation.](https://helpers.yunohost.org/)
- Add a `LICENSE` file for the package.
- Edit `README.md` and README_fr.md.

# Example app for YunoHost

[![Integration level](https://dash.yunohost.org/integration/REPLACEBYYOURAPP.svg)](https://dash.yunohost.org/appci/app/REPLACEBYYOURAPP)  
[![Install REPLACEBYYOURAPP with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=REPLACEBYYOURAPP)

*[Lire ce readme en français.](./README_fr.md)*

> *This package allow you to install REPLACEBYYOURAPP quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview
Quick description of this app.

**Shipped version:** 1.0

## Screenshots

![](Link to an screenshot for this app)

## Demo

* [Official demo](Link to a demo site for this app)

## Configuration

How to configure this app: by an admin panel, a plain file with SSH, or any other way.

## Documentation

 * Official documentation: Link to the official documentation of this app
 * YunoHost documentation: If specific documentation is needed, feel free to contribute.

## YunoHost specific features

#### Multi-users support

Are LDAP and HTTP auth supported?
Can the app be used by multiple users?

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/REPLACEBYYOURAPP%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/REPLACEBYYOURAPP/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/REPLACEBYYOURAPP%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/REPLACEBYYOURAPP/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/ci/logs/REPLACEBYYOURAPP%20%28Apps%29.svg)](https://ci-stretch.nohost.me/ci/apps/REPLACEBYYOURAPP/)

## Limitations

* Any known limitations.

## Additional information

* Other information you would add about this application

**More information on the documentation page:**  
https://yunohost.org/packaging_apps

## Links

 * Report a bug: https://github.com/YunoHost-Apps/REPLACEBYYOURAPP_ynh/issues
 * App website: Link to the official website of this app
 * Upstream app repository: Link to the official repository of the upstream app
 * YunoHost website: https://yunohost.org/

---

Developers info
----------------

**Only if you want to use a testing branch for coding, instead of merging directly into master.**
Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/REPLACEBYYOURAPP_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/REPLACEBYYOURAPP_ynh/tree/testing --debug
or
sudo yunohost app upgrade REPLACEBYYOURAPP -u https://github.com/YunoHost-Apps/REPLACEBYYOURAPP_ynh/tree/testing --debug
```
