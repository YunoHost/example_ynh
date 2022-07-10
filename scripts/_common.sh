#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================
# PHP APP SPECIFIC
#=================================================
# PHP version used by the application can be changed here
# YunoHost uses a "default php" version depending of its version
## YunoHost version "11.X" => php 7.4
## YunoHost version "4.X"  => php 7.3
#
# This behaviour can be overrided by setting the variable
#YNH_PHP_VERSION=7.3
#YNH_PHP_VERSION=7.4
#YNH_PHP_VERSION=8.0
# For more information, see the "php helper": https://github.com/YunoHost/yunohost/blob/dev/helpers/php#L3-L6=
# Or this php package: https://github.com/YunoHost-Apps/grav_ynh/blob/master/scripts/_common.sh

# dependencies used by the app (must be on a single line)
pkg_dependencies="deb1 deb2 php$YNH_PHP_VERSION-deb1 php$YNH_PHP_VERSION-deb2"

#=================================================
# PERSONAL HELPERS
#=================================================

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
