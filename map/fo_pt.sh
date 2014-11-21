set -e -o pipefail

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM fo_pt WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep fo_pt | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['natural', 'landform', 'landform', 'pingo'] $mid '108007%' $end" | $connect

