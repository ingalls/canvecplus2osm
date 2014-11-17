set -e -o pipefail
echo "Extracting TO_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM to_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep to_pg | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "  DONE"
