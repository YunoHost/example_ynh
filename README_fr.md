# Emballage d'une application, à partir de cet exemple

* Copier cette application avant de travailler dessus, en utilisant le bouton ['Use this template'](https://github.com/new?template_name=example_ynh&template_owner=YunoHost) sur le repo GitHub.
* Editer le fichier `manifest.toml` avec les informations spécifiques à l'application.
* Editer les scripts `install`, `upgrade`, `remove`, `backup` et `restore`, et tous les fichiers de conf pertinents dans `conf/`.
  * Utiliser la [documentation sur les aides aux scripts] (https://yunohost.org/packaging_apps_helpers).
* Éditez aussi les scripts `change_url` et `config`, ou supprimez-les si vous n'en avez pas l'utilité.
* Ajouter un fichier `LICENSE` pour le paquet. NB : ce fichier LICENSE n'est pas nécessairement la LICENSE de l'application en amont - c'est seulement la LICENSE avec laquelle vous voulez que le code de ce paquet soit publié ;). Nous recommandons d'utiliser [l'AGPL-3] (https://www.gnu.org/licenses/agpl-3.0.txt).
* Editer les fichiers dans le répertoire `doc/`.
* Les fichiers `README.md` doivent être générés automatiquement par <https://github.com/YunoHost/apps/tree/main/tools/readme_generator>

---
<!--
N.B. : Ce README a été généré automatiquement par https://github.com/YunoHost/apps/tree/main/tools/readme_generator
Il ne doit PAS être édité à la main.
-->

# Exemple d'app pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/example.svg)](https://dash.yunohost.org/appci/app/example) ![Statut du fonctionnement](https://ci-apps.yunohost.org/ci/badges/example.status.svg) ![Statut de maintenance](https://ci-apps.yunohost.org/ci/badges/example.maintain.svg)  
[![Installer Example app avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=example)

*[Read this readme in english.](./README.md)*

> *Ce package vous permet d'installer Example app rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Some long and extensive description of what the app is and does, lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

### Features

- Ut enim ad minim veniam, quis nostrud exercitation ullamco ;
- Laboris nisi ut aliquip ex ea commodo consequat ;
- Duis aute irure dolor in reprehenderit in voluptate ;
- Velit esse cillum dolore eu fugiat nulla pariatur ;
- Excepteur sint occaecat cupidatat non proident, sunt in culpa."


**Version incluse :** 1.0~ynh1

**Démo :** https://demo.example.com

## Captures d'écran

![Capture d'écran de Example app](./doc/screenshots/example.jpg)

## Avertissements / informations importantes

* Any known limitations, constrains or stuff not working, such as (but not limited to):
    * requiring a full dedicated domain ?
    * architectures not supported ?
    * not-working single-sign on or LDAP integration ?
    * the app requires an important amount of RAM / disk / .. to install or to work properly
    * etc...

* Other infos that people should be aware of, such as:
    * any specific step to perform after installing (such as manually finishing the install, specific admin credentials, ...)
    * how to configure / administrate the application if it ain't obvious
    * upgrade process / specificities / things to be aware of ?
    * security considerations ?

## Documentations et ressources

* Site officiel de l'app : <https://example.com>
* Documentation officielle utilisateur : <https://yunohost.org/apps>
* Documentation officielle de l'admin : <https://yunohost.org/packaging_apps>
* Dépôt de code officiel de l'app : <https://some.forge.com/example/example>
* Documentation YunoHost pour cette app : <https://yunohost.org/app_example>
* Signaler un bug : <https://github.com/YunoHost-Apps/example_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/example_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.

``` bash
sudo yunohost app install https://github.com/YunoHost-Apps/example_ynh/tree/testing --debug
ou
sudo yunohost app upgrade example -u https://github.com/YunoHost-Apps/example_ynh/tree/testing --debug
```

**Plus d'infos sur le packaging d'applications :** <https://yunohost.org/packaging_apps>
