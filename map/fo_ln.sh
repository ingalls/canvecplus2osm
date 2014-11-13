echo "Extracting FO_LN"

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM fo_ln WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['natural', 'landform', 'landform', 'esker'] $mid '108002%' $end" | $connect
