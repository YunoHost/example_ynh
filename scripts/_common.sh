#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

# FIRES is a pnpm monorepo; the reference server lives in this subdirectory.
fires_dir="components/fires-server"

# Default values for the FIRES environment variables that are exposed as
# settings (and tunable from the config panel). These are seeded during
# install and kept across upgrades.
default_log_level="info"
default_database_pool_min="2"
default_database_pool_max="10"

#=================================================
# CUSTOM HELPERS
#=================================================

# Build the AdonisJS reference server and assemble its production runtime,
# mirroring the upstream Dockerfile build stages.
# Expects $install_dir, $fires_dir and node/corepack to be in PATH.
build_fires() {
    local build_dir="$install_dir/$fires_dir/build"
    # Deploy outside the workspace (pnpm refuses to deploy into the workspace
    # tree) and into a path that does not exist yet.
    local deploy_parent deploy_dir
    deploy_parent="$(mktemp -d)"
    deploy_dir="$deploy_parent/fires-server-deploy"

    pushd "$install_dir"
        # Enable the pnpm version pinned in the repo's packageManager field
        ynh_hide_warnings corepack enable
        ynh_hide_warnings corepack prepare --activate

        # Install workspace deps (skip the docs site) and build the server,
        # which compiles to components/fires-server/build
        ynh_hide_warnings pnpm install --filter '!@fedimod/fires-docs' --frozen-lockfile
        ynh_hide_warnings pnpm run --filter=@fedimod/fires-server -r build

        # Produce a pruned, production-only deployment (node_modules + manifest)
        ynh_hide_warnings pnpm deploy --filter=@fedimod/fires-server --prod "$deploy_dir"
    popd

    # Assemble the runtime exactly like the Dockerfile's final stage:
    # compiled output + production node_modules + its package manifest.
    cp -a "$deploy_dir/node_modules" "$build_dir/node_modules"
    cp -a "$deploy_dir/package.json" "$build_dir/package.json"

    ynh_safe_rm "$deploy_parent"
}

# Run pending database migrations against the compiled build.
migrate_fires() {
    pushd "$install_dir/$fires_dir/build"
        ynh_hide_warnings node ace migration:run --force
    popd
}
