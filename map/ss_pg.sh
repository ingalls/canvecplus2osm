set -e -o pipefail

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ss_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep ss_pg | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['natural', 'wetland', 'wetland', 'tundra_pond'] $mid '132001%' $end" | $connect
echo "$pre ARRAY['natural', 'wetland', 'wetland', 'palsa_bog'] $mid '132002%' $end" | $connect
echo "$pre ARRAY['natural', 'wetland'] $mid '132003%' $end" | $connect
echo "$pre ARRAY['natural', 'wetland'] $mid '132004%' $end" | $connect
echo "$pre ARRAY['natural', 'wetland', 'wetland', 'string_bog'] $mid '132005%' $end" | $connect

