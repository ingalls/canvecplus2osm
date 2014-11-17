set -e -o pipefail
echo "Extracting EN_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM en_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep en_pg | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['landuse', 'industrial'] $mid '1360040' $end" | $connect
echo "$pre ARRAY['landuse', 'industrial'] $mid '1360042' $end" | $connect
echo "$pre ARRAY['power', 'sub_station'] $mid '1360050' $end" | $connect
echo "$pre ARRAY['power', 'sub_station'] $mid '1360052' $end" | $connect

echo "  DONE"
