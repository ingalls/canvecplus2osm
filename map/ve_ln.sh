set -e -o pipefail

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ve_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep ve_ln | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['man_made', 'cutline'] $mid '229001%' $end" | $connect
echo "$pre ARRAY['man_made', 'cutline'] $mid '229002%' $end" | $connect
echo "$pre ARRAY['man_made', 'cutline'] $mid '229003%' $end" | $connect

