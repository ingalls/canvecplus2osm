echo "Extracting LX_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM lx_pt WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['amenity', 'cinema', 'foot', 'no'] $mid '207001%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'note', 'remote area building'] $mid '203001%' $end" | $connect
echo "$pre ARRAY['historic', 'ruins'] $mid '240001%' $end" | $connect
echo "$pre ARRAY['history', 'wayside_shrine'] $mid '221001%' $end" | $connect
echo "$pre ARRAY['landuse', 'cemetery'] $mid '100003%' $end" | $connect
echo "$pre ARRAY['leisure', 'golf_driving_range'] $mid '250001%' $end" | $connect
echo "$pre ARRAY['leisure', 'marina'] $mid '100006%' $end" | $connect
echo "$pre ARRAY['leisure', 'sports_centre', 'sport', 'skiing'] $mid '100002%' $end" | $connect
echo "$pre ARRAY['tourism', 'attraction', 'historic', 'yes'] $mid '222001%' $end" | $connect
echo "$pre ARRAY['tourism', 'campground'] $mid '248001%' $end" | $connect
echo "$pre ARRAY['tourism', 'picnic_site'] $mid '249001%' $end" | $connect
echo "$pre ARRAY['tourism', 'viewpoint'] $mid '100001%' $end" | $connect
