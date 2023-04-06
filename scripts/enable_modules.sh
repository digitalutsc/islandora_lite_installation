#!/bin/bash

source $(dirname $0)/site_config.sh

#Enable modules
"$drush" -y pm:enable responsive_image syslog devel admin_toolbar pdf matomo restui controlled_access_terms_defaults jsonld fontawesome field_group field_permissions features file_entity view_mode_switch replaywebpage views_timelinejs islandora_defaults islandora_marc_countries fico fico_taxonomy_condition openseadragon ableplayer csvfile_formatter archive_list_contents islandora_iiif islandora_display advanced_search media_thumbnails media_thumbnails_pdf media_thumbnails_video media_library_edit migrate_source_csv migrate_tools basic_auth islandora_site_name islandora_lite_solr_search islandora_mirador term_condition filemime views_flipped_table islandora_breadcrumbs rest_oai_pmh citation_select asset_injector better_social_sharing_buttons structure_sync islandora_search_processor facets_year_range views_nested_details

"$drush" -y pm:enable media_thumbnails_tiff

"$drush" -y migrate:import islandora_tags

"$drush" -y then olivero
"$drush" -y config-set system.theme default olivero

"$drush" -y pm:uninstall search
