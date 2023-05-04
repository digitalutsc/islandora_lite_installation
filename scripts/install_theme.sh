#!/bin/bash

source $(dirname $0)/site_config.sh

git clone https://github.com/digitalutsc/dsu_sites_config "${site_path}"/dsu_sites_config


# Download utsc logo 
wget -P "${site_path}"/web/sites/default/files https://digital.utsc.utoronto.ca/sites/default/files/logo.svg 

# Assume ssh-key is setup, and be able to download private github repo
git clone -b doris git@github.com:digitalutsc/dsu_subtheme_barrioDepartments.git "${site_path}"/web/themes/contrib/dsu_subtheme_barrioDepartments

# clear cache
"$drush" cr

# enable theme
"$drush" -y then barriodepartments
"$drush" -y config-set system.theme default barriodepartments

# enable theme settings
"$drush" -y config-import --partial --source="${site_path}"/dsu_sites_config/all/themes

# import configs for TimelineJS
"$drush" -y config-import --partial --source="${site_path}"/dsu_sites_config/all/timelinejs

# import custom blocks
"$drush" ib

# enable blocks 
"$drush" -y config-import --partial --source="${site_path}"/dsu_sites_config/all/blocks

# clear cache
"$drush" cr

"$drush" -y config-set block.block.barriodepartments_miradorblock settings.iiif_manifest_url "$site_url"/node/[node:nid]/book-manifest
