#!/bin/bash

source $(dirname $0)/site_config.sh

# configuring Search API server
"$drush" -y config-set search_api.server.default_solr_server backend_config.connector_config.scheme https
"$drush" -y config-set search_api.server.default_solr_server backend_config.connector_config.host ${solr_host}
"$drush" -y config-set search_api.server.default_solr_server backend_config.connector_config.core ${solr_core}

# IIIF server configs
"$drush" -y config:set openseadragon.settings iiif_server "$cantaloupe_url"
"$drush" -y config:set openseadragon.settings manifest_view "iiif_manifest"
"$drush" -y config:set islandora_iiif.settings iiif_server "$cantaloupe_url"
"$drush" -y config:set islandora_mirador.settings iiif_manifest_url "$site_url"/media/[media:mid]/manifest

# Ensure standalone_url is enabled
"$drush" -y config:set media.settings standalone_url true

# configure document mimetypes
"$drush" -y --input-format=yaml config:set file_entity.type.document mimetypes "
- text/plain
- application/msword
- application/vnd.ms-excel
- application/pdf
- application/vnd.ms-powerpoint
- application/vnd.oasis.opendocument.text
- application/vnd.oasis.opendocument.spreadsheet
- application/vnd.oasis.opendocument.presentation
- application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
- application/vnd.openxmlformats-officedocument.presentationml.presentation
- application/vnd.openxmlformats-officedocument.wordprocessingml.document
- text/csv
- text/vtt
- text/x-gettext-translation"

"$drush" -y --input-format=yaml config:set file_entity.type.image mimetypes "
- image/*
- image/tiff
- image/tif
- image/jp2"


"$drush" -y config:set field.field.media.document.field_media_document settings.file_extensions "txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages csv vtt po"
"$drush" -y config:set field.field.media.image.field_media_image settings.file_extensions "png gif jpg jpeg tif tiff jp2"
"$drush" -y config:set field.field.media.audio.field_media_audio_file settings.file_extensions "mp3 wav aac m4a"

# not sure where to set this in isle-dc
"$drush" -y config:set search_api.server.default_solr_server backend_config.connector_config.core "$solr_core"

# set front page
"$drush" -y config:set system.site page.front "/collections"

# Additional file mime types
"$drush" -y  config:set filemime.settings types "
image/jp2 jp2
application/gzip warc
application/gzip wacz
application/vnd.apple.mpegurl m3u8
application/json json
text/x-gettext-translation po"

"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/asset_injector

# enable theme batrik
"$drush" -y then bartik
