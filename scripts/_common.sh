#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="deb1 deb2 php$YNH_DEFAULT_PHP_VERSION-deb1 php$YNH_DEFAULT_PHP_VERSION-deb2"

#=================================================
# PERSONAL HELPERS
#=================================================

function test_folder {
	test ! -e "$final_path" || ynh_die --message="$final_path path already contains a directory"
}

function install_dependencies {
	### `ynh_install_app_dependencies` allows you to add any "apt" dependencies to the package.
	### Those deb packages will be installed as dependencies of this package.
	### If you're not using this helper:
	###		- Remove the section "REMOVE DEPENDENCIES" in the remove script
	###		- Remove the variable "pkg_dependencies" in _common.sh
	###		- As well as the section "REINSTALL DEPENDENCIES" in the restore script
	###		- And the section "UPGRADE DEPENDENCIES" in the upgrade script

	ynh_install_app_dependencies $pkg_dependencies
}

function configure_system_user {
		ynh_system_user_create --username=$app --home_dir="$final_path"
}

function setup_source {
	### `ynh_setup_source` is used to install an app from a zip or tar.gz file,
	### downloaded from an upstream source, like a git repository.
	### `ynh_setup_source` use the file conf/app.src

	# Download, check integrity, uncompress and patch the source from app.src
	ynh_setup_source --dest_dir="$final_path"

	set_permissions
}

function set_permissions {
	# FIXME: this should be managed by the core in the future
	# Here, as a packager, you may have to tweak the ownerhsip/permissions
	# such that the appropriate users (e.g. maybe www-data) can access
	# files in some cases.
	# But FOR THE LOVE OF GOD, do not allow r/x for "others" on the entire folder -
	# this will be treated as a security issue.
	chown -R $app:www-data "$final_path"
	chmod -R g=u,g-w,o-rwx "$final_path"
}

function add_config {
	### You can add specific configuration files.
	###
	### Typically, put your template conf file in ../conf/your_config_file
	### The template may contain strings such as __FOO__ or __FOO_BAR__,
	### which will automatically be replaced by the values of $foo and $foo_bar
	###
	### ynh_add_config will also keep track of the config file's checksum,
	### which later during upgrade may allow to automatically backup the config file
	### if it's found that the file was manually modified
	###
	### Check the documentation of `ynh_add_config` for more info.

	set_config_permissions

	ynh_add_config --template="some_config_file" --destination="$final_path/some_config_file"

	### For more complex cases where you want to replace stuff using regexes,
	### you shoud rely on ynh_replace_string (which is basically a wrapper for sed)
	### When doing so, you also need to manually call ynh_store_file_checksum
	###
	### ynh_replace_string --match_string="match_string" --replace_string="replace_string" --target_file="$final_path/some_config_file"
	### ynh_store_file_checksum --file="$final_path/some_config_file"
}

function set_config_permissions {
	# FIXME: this should be handled by the core in the future
	# You may need to use chmod 600 instead of 400,
	# for example if the app is expected to be able to modify its own config
	chmod 400 "$final_path/some_config_file"
	chown $app:$app "$final_path/some_config_file"
}

function integrate_service {
	### `yunohost service add` integrates a service in YunoHost. It then gets
	### displayed in the admin interface and through the others `yunohost service` commands.
	### (N.B.: this line only makes sense if the app adds a service to the system!)
	### If you're not using these lines:
	###		- You can remove these files in conf/.
	###		- Remove the section "REMOVE SERVICE INTEGRATION IN YUNOHOST" in the remove script
	###		- As well as the section "INTEGRATE SERVICE IN YUNOHOST" in the restore script
	###		- And the section "INTEGRATE SERVICE IN YUNOHOST" in the upgrade script

	yunohost service add $app --description="A short description of the app" --log="/var/log/$app/$app.log"

	### Additional options starting with 3.8:
	###
	### --needs_exposed_ports "$port" a list of ports that needs to be publicly exposed
	###                               which will then be checked by YunoHost's diagnosis system
	###                               (N.B. DO NOT USE THIS is the port is only internal!!!)
	###
	### --test_status "some command"  a custom command to check the status of the service
	###                               (only relevant if 'systemctl status' doesn't do a good job)
	###
	### --test_conf "some command"    some command similar to "nginx -t" that validates the conf of the service
	###
	### Re-calling 'yunohost service add' during the upgrade script is the right way
	### to proceed if you later realize that you need to enable some flags that
	### weren't enabled on old installs (be careful it'll override the existing
	### service though so you should re-provide all relevant flags when doing so)
}

function start_service {
	### `ynh_systemd_action` is used to start a systemd service for an app.
	### Only needed if you have configure a systemd service
	### If you're not using these lines:
	###		- Remove the section "STOP SYSTEMD SERVICE" and "START SYSTEMD SERVICE" in the backup script
	###		- As well as the section "START SYSTEMD SERVICE" in the restore script
	###		- As well as the section"STOP SYSTEMD SERVICE" and "START SYSTEMD SERVICE" in the upgrade script
	###		- And the section "STOP SYSTEMD SERVICE" and "START SYSTEMD SERVICE" in the change_url script

	# Start a systemd service
	ynh_systemd_action --service_name=$app --action="start" --log_path="/var/log/$app/$app.log"
}

function stop_service {
	ynh_systemd_action --service_name=$app --action="stop" --log_path="/var/log/$app/$app.log"
}

function setup_fail2ban {
	ynh_add_fail2ban_config --logpath="/var/log/nginx/${domain}-error.log" --failregex="Regex to match into the log for a failed login"
}

function load_settings {
	app=$YNH_APP_INSTANCE_NAME

	final_path=$(ynh_app_setting_get --app=$app --key=final_path)
	domain=$(ynh_app_setting_get --app=$app --key=domain)
	path_url=$(ynh_app_setting_get --app=$app --key=path)
	language=$(ynh_app_setting_get --app=$app --key=language)
	password=$(ynh_app_setting_get --app=$app --key=password)
	port=$(ynh_app_setting_get --app=$app --key=port)
	db_name=$(ynh_app_setting_get --app=$app --key=db_name)
	db_user=$db_name
	db_pwd=$(ynh_app_setting_get --app=$app --key=mysqlpwd)
	phpversion=$(ynh_app_setting_get --app=$app --key=phpversion)
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
