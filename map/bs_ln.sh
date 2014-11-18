set -e -o pipefail

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM bs_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep bs_ln | wc -l) = "0" ]; then
    exit 0
fi


echo "$pre ARRAY['power', 'minor_line', 'fixme', 'conform power/comms line'] $mid '223001%' $end" | $connect
echo "$pre ARRAY['barrier', 'fence'] $mid '224001%' $end" | $connect
echo "$pre ARRAY['barrier', 'wall'] $mid '224002%' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline'] $mid '231001%' $end" | $connect
