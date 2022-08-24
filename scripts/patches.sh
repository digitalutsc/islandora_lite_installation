#!/bin/bash

source $(dirname $0)/site_config.sh

current_path="$PWD"

wget https://www.drupal.org/files/issues/2022-02-10/deprecated-3084136-3.patch -P "$site_path"/web/modules/contrib/fico
cd "$site_path"/web/modules/contrib/fico && patch --forward -p1 < deprecated-3084136-3.patch
cd "$current_path"

cp "$islandora_lite_installation_path"/patches/workbench_integration.patch "$site_path"/web/modules/contrib/islandora_workbench_integration/
cd "$site_path"/web/modules/contrib/islandora_workbench_integration && patch --forward -p1 < workbench_integration.patch
cd "$current_path"

cp "$islandora_lite_installation_path"/patches/mods_view_render.patch "$site_path"/web/modules/contrib/rest_oai_pmh/
cd "$site_path"/web/modules/contrib/rest_oai_pmh && patch --forward -p1 < mods_view_render.patch
cd "$current_path"

cp  "$islandora_lite_installation_path"/templates/mods.html.twig "$site_path"/web/modules/contrib/rest_oai_pmh/templates

"$drush" pm:enable islandora_workbench_integration

wget https://raw.githubusercontent.com/digitalutsc/islandora_lite_installation/main/patches/advanced_search_issues_9.patch -P "$site_path"/web/modules/contrib/facets
cd "$site_path"/web/modules/contrib/facets && patch --forward -p1 < advanced_search_issues_9.patch
cd "$current_path"

wget https://raw.githubusercontent.com/digitalutsc/islandora_lite_installation/main/patches/accessibility_views_flipped_table_convert_to_layout_table.patch -P "$site_path"/web/modules/contrib/views_flipped_table
cd "$site_path"/web/modules/contrib/views_flipped_table && patch --forward -p1 < accessibility_views_flipped_table_convert_to_layout_table.patch
cd "$current_path"
