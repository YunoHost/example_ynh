#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
# PHP APP SPECIFIC
#=================================================
# Depending on its version, YunoHost uses different default PHP version:
## YunoHost version "11.X" => PHP 7.4
## YunoHost version "4.X"  => PHP 7.3
#
# This behaviour can be overridden by setting the YNH_PHP_VERSION variable
#YNH_PHP_VERSION=7.3
#YNH_PHP_VERSION=7.4
#YNH_PHP_VERSION=8.0
# For more information, see the PHP application helper: https://github.com/YunoHost/yunohost/blob/dev/helpers/php#L3-L6
# Or this app package depending on PHP: https://github.com/YunoHost-Apps/grav_ynh/blob/master/scripts/_common.sh
# PHP dependencies used by the app (must be on a single line)
#php_dependencies="php$YNH_PHP_VERSION-deb1 php$YNH_PHP_VERSION-deb2"
# or, if you do not need a custom YNH_PHP_VERSION:
php_dependencies="php$YNH_DEFAULT_PHP_VERSION-deb1 php$YNH_DEFAULT_PHP_VERSION-deb2"

# dependencies used by the app (must be on a single line)
pkg_dependencies="deb1 deb2 $php_dependencies"

#=================================================
# PERSONAL HELPERS
#=================================================

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
