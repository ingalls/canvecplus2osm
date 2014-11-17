set -e -o pipefail
echo "Extracting FO_LN"

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM fo_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep fo_ln | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['natural', 'landform', 'landform', 'esker'] $mid '108002%' $end" | $connect

echo "  DONE"
