echo "Extracting LI_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM li_pg WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['boundary', 'administrative', 'admin_level', '5'] $mid '168001%' $end" | $connect
echo "$pre ARRAY['boundary', 'administrative', 'admin_level', '6'] $mid '168002%' $end" | $connect
echo "$pre ARRAY['boundary', 'administrative', 'admin_level', '8'] $mid '168003%' $end" | $connect
