echo "Extracting BG_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM bs_pt WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['natural', 'landform', 'landform', 'pingo'] $mid '108007%' $end" | $connect

