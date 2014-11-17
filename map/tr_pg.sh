set -e -o pipefail
echo "Extracting TR_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM tr_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep tr_pg | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['aeroway','apron','fixme','Feature includes runway-taxiway-apron geometries'] $mid '119003%' $end" | $connect
echo "$pre ARRAY['aeroway','apron','fixme','Feature includes runway-taxiway-apron geometries'] $mid '119006%' $end" | $connect
echo "$pre ARRAY['aeroway','apron','fixme','Feature includes runway-taxiway-apron geometries'] $mid '119010%' $end" | $connect

echo "  DONE"
