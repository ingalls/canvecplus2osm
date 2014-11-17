set -e -o pipefail
echo "Extracting VE_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ve_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep ve_pg | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['natural', 'wood'] $mid '124001%' $end" | $connect
echo "$pre ARRAY['natural', 'wood'] $mid '124002%' $end" | $connect
echo "$pre ARRAY['natural', 'wood'] $mid '124003%' $end" | $connect
echo "$pre ARRAY['natural', 'wood'] $mid '124004%' $end" | $connect

echo "  DONE"
