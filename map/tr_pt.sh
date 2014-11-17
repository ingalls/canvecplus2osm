set -e -o pipefail
echo "Extracting TR_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM tr_pt WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep tr_pt | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['aeroway','apron','fixme','Feature includes runway-taxiway-apron geometries'] $mid '119003%' $end" | $connect
echo "$pre ARRAY['aeroway','helipad'] $mid '119004%' $end" | $connect
echo "$pre ARRAY['aeroway','helipad'] $mid '119005%' $end" | $connect
echo "$pre ARRAY['aeroway','apron','fixme','Feature includes runway-taxiway-apron geometries'] $mid '119006%' $end" | $connect
echo "$pre ARRAY['aeroway','helipad'] $mid '119007%' $end" | $connect
echo "$pre ARRAY['aeroway','helipad'] $mid '119008%' $end" | $connect
echo "$pre ARRAY['aeroway','aerodrome', 'fixme', 'relocate installation on ground'] $mid '119009%' $end" | $connect
echo "$pre ARRAY['aeroway','apron','fixme','Feature includes runway-taxiway-apron geometries'] $mid '119010%' $end" | $connect
echo "$pre ARRAY['aeroway','helipad'] $mid '119011%' $end" | $connect
echo "$pre ARRAY['aeroway','aerodrome', 'fixme', 'relocate installation on ground'] $mid '119012%' $end" | $connect
echo "$pre ARRAY['amenity','ferry_terminal'] $mid '177003%' $end" | $connect
echo "$pre ARRAY['barrier','block'] $mid '178001%' $end" | $connect
echo "$pre ARRAY['barier','gate'] $mid '178001%' $end" | $connect
echo "$pre ARRAY['highway','toll'] $mid '179001%' $end" | $connect
echo "$pre ARRAY['railway','turntable'] $mid '232001%' $end" | $connect

echo "  DONE"
