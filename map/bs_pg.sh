echo "Extracting BG_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM bs_pg WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['landuse', 'residential'] $mid '137001%' $end" | $connect
echo "$pre ARRAY['building', 'yes'] $mid '201001%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'leisure', 'sports_centre'] $mid '201002%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'landuse', 'military', 'note', 'armoury building'] $mid '201003%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'townhall'] $mid '201006%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'coast_guard'] $mid '201007%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'community_centre'] $mid '201008%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'courthouse'] $mid '201009%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'customs'] $mid '201010%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'power', 'generator'] $mid '201012%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'fire_station'] $mid '201013%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'highway', 'services'] $mid '201017%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'hospital'] $mid '201018%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'doctors'] $mid '201020%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'townhall'] $mid '201021%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'note', 'Gas and oil facilities building'] $mid '201024%' $end" | $connect
echo "$pre ARRAY['building', 'yes'] $mid '201025%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'note', 'parliament building'] $mid '201026%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'police'] $mid '201027%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'railway', 'station'] $mid '201028%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'note', 'Satellite tracking station'] $mid '201030%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'leisure', 'sports_centre'] $mid '201033%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'landuse', 'industrial'] $mid '201038%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'place_of_worship'] $mid '201039%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'prison'] $mid '201040%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'school'] $mid '201042%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208001%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208002%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208003%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank', 'content', 'water'] $mid '208004%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208005%' $end" | $connect
echo "$pre ARRAY['landuse', 'reservoir', 'note', 'underground reservoir'] $mid '238001%' $end" | $connect
