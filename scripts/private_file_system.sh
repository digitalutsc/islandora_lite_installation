#!/bin/bash

source $(dirname $0)/site_config.sh

# configure file system
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/private_file_system/system

# configure media's file fields
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/private_file_system/media


# Apply patch for file_entity
wget https://raw.githubusercontent.com/digitalutsc/override_permission_file_entity/main/override_file_access.patch -P "${site_path}"/web/modules/contrib/file_entity
cd "${site_path}"/web/modules/contrib/file_entity && patch -p1 < override_file_access.patch && cd "$islandora_lite_installation_path"
