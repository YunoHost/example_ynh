# Example app for YunoHost

- [Yunohost project](https://yunohost.org)
- [Exemple app website](https://example.com)

Description of the app.

## Usage
- Copy this app before work on it.
- Edit `conf/nginx.conf` file to match application prerequisites.
- Edit `manifest.json` with application specific information.
- Edit the `install`, `upgrade`, `remove`, `backup`, and `restore` scripts.
- Add a `LICENSE` file for the package.
- Edit `README.md`.

**More information on the documentation page:**    
https://yunohost.org/packaging_apps

**Upgrade this package:**  
`sudo yunohost app upgrade --verbose example -u https://github.com/YunoHost-Apps/example_ynh`

**Multi-user:** Yes/No. How about the ldap and HTTP auth support.
