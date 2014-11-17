set -e -o pipefail
echo "Extracting SS_LN"

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ss_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep ss_ln | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "  DONE"
