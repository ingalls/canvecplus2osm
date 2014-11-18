set -e -o pipefail

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM bs_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep fo_pg | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['natural', 'landform', 'landform', 'glacial_debris'] $mid '108003%' $end" | $connect
echo "$pre ARRAY['natural', 'landform', 'landform', 'moraine'] $mid '108004%' $end" | $connect
echo "$pre ARRAY['natural', 'beach', 'fixme', 'could be dunes for raised beach'] $mid '108005%' $end" | $connect
echo "$pre ARRAY['natural', 'landform', 'landform', 'tundra_polygon'] $mid '108007%' $end" | $connect

