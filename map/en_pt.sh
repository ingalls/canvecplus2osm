set -e -o pipefail
echo "Extracting EN_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM en_pt WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep en_pt | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['power', 'generator', 'power_source', 'wind'] $mid '2170010' $end" | $connect
echo "$pre ARRAY['landuse', 'industrial'] $mid '1360040' $end" | $connect
echo "$pre ARRAY['landuse', 'industrial'] $mid '1360042' $end" | $connect
echo "$pre ARRAY['pipeline', 'valve'] $mid '1340010 ' $end" | $connect
echo "$pre ARRAY['power', 'sub_station'] $mid '1360050' $end" | $connect
echo "$pre ARRAY['power', 'sub_station'] $mid '1360052' $end" | $connect

echo "  DONE"
