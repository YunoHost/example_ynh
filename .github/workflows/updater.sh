#!/bin/bash

#=================================================
# PACKAGE UPDATING HELPER
#=================================================

# This script is meant to be run by GitHub actions: check out .github/workflows/updater.yml
# Since each app is different, maintainers can adapt its contents so as to perform
# automatic actions when a new upstream release is detected.

# GitHub Actions should have made available the following environment variables:
# $ASSETS:
#   The ASSETS environment variable is a space-separated list of urls
#   of assets published with the latest upstream release.
# $VERSION:
#   The new version of the app

# Let's convert $ASSETS into an array.
eval "ASSETS=($ASSETS)"
echo "${#ASSETS[@]} available asset(s)"

#=================================================
# UPDATE SOURCE FILES
#=================================================

# Here we use the $ASSETS variable to get the resources published
# in the upstream release.
# Here is an example for Grav, it has to be adapted in accordance with
# how the upstream releases look like.

# Let's loop over the array of assets URLs
for asset_url in ${ASSETS[@]}; do

echo "Handling asset at $asset_url"

# Assign the asset to a source file in conf/ directory
# Here we base the source file name upon a unique keyword in the assets url (admin vs. update)
# Leave $src empty to ignore the asset
case $asset_url in
  *"admin"*)
    src="app"
    ;;
  *"update"*)
    src="app-upgrade"
    ;;
  *)
    src=""
    ;;
esac

# If $src is not empty, let's process the asset
if [ ! -z "$src" ]; then

# Create the temporary directory
tempdir="$(mktemp -d)"

# Download sources and calculate checksum
filename=${asset_url##*/}
curl --silent -4 -L $asset_url -o "$tempdir/$filename"
checksum=$(sha256sum "$tempdir/$filename" | head -c 64)

# Delete temporary directory
rm -rf $tempdir

# Get extension
if [[ $filename == *.tar.gz ]]; then
  extension=tar.gz
else
  extension=${filename##*.}
fi

# Rewrite source file
cat <<EOT > conf/$src.src
SOURCE_URL=$asset_url
SOURCE_SUM=$checksum
SOURCE_SUM_PRG=sha256sum
SOURCE_FORMAT=$extension
SOURCE_IN_SUBDIR=true
SOURCE_FILENAME=
EOT
echo "... conf/$src.src updated"

else
echo "... asset ignored"
fi

done

#=================================================
# SPECIFIC UPDATE STEPS
#=================================================

# Any action on the app's source code can be done.
# The GitHub Action workflow takes care of committing all changes
# after this script ends.

# Note that there should be no need to tune manifest.json or the READMEs, since
# the GitHub Action workflow and yunohost-bot take care of them, respectively.

#=================================================
# GENERIC FINALIZATION
#=================================================

echo "Done!"
