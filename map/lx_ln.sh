set -e -o pipefail

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM lx_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep lx_ln | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['highway', 'footway'] $mid '242001%' $end" | $connect
echo "$pre ARRAY['highway', 'footway'] $mid '242002%' $end" | $connect
echo "$pre ARRAY['highway', 'footway', 'bridge', 'yes'] $mid '228001%' $end" | $connect
echo "$pre ARRAY['highway', 'footway', 'sport', 'canoe'] $mid '242003%' $end" | $connect
echo "$pre ARRAY['leisure', 'track', 'fixme', 'sport type is not known'] $mid '100007%' $end" | $connect

