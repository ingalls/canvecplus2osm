echo "Extracting TO_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM to_pt WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['place', 'city'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'town'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'village'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'hamlet'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'suburb', 'fixme', 'Place type may not be valid'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'suburb', 'fixme', 'Place type may not be valid'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'suburb', 'fixme', 'Place type may not be valid'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'suburb', 'fixme', 'Place type may not be valid'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'suburb', 'fixme', 'Place type may not be valid'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['place', 'suburb', 'fixme', 'Place type may not be valid'] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
echo "$pre ARRAY['', ''] $mid '158001%' $end" | $connect
