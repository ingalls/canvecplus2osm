echo "Extracting BG_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM bs_pt WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['man_made', 'beacon'] $mid '125001%' $end" | $connect
echo "$pre ARRAY['man_made', 'beacon', 'fixme', 'could be a beacon with a light'] $mid '125002%' $end" | $connect
echo "$pre ARRAY['man_made', 'beacon'] $mid '125003%' $end" | $connect
echo "$pre ARRAY['man_made', 'tower', 'note', 'Radar parabolic antenna'] $mid '200001%' $end" | $connect
echo "$pre ARRAY['man_made', 'tower', 'note', 'Radar telescope parabolic antenna'] $mid '200002%' $end" | $connect
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
echo "$pre ARRAY['building', 'yes', 'note', 'parliament building'] $mid '201026%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'police'] $mid '201027%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'railway', 'station'] $mid '201028%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'note', 'Satellite tracking station'] $mid '201030%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'leisure', 'sports_centre'] $mid '201033%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'place_of_worship'] $mid '201039%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'prison'] $mid '201040%' $end" | $connect
echo "$pre ARRAY['building', 'yes', 'amenity', 'school'] $mid '201042%' $end" | $connect
echo "$pre ARRAY['man_made', 'chimney'] $mid '206001%' $end" | $connect
echo "$pre ARRAY['man_made', 'chimney', 'note', 'wood burner'] $mid '206002%' $end" | $connect
echo "$pre ARRAY['man_made', 'chimney', 'note', 'Industrial'] $mid '206003%' $end" | $connect
echo "$pre ARRAY['man_made', 'chimney', 'note', 'Flare stack'] $mid '206004%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208001%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208002%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208003%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank', 'content', 'water'] $mid '208004%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage_tank'] $mid '208005%' $end" | $connect
echo "$pre ARRAY['historic', 'memorial'] $mid '212001%' $end" | $connect
echo "$pre ARRAY['man_made', 'well'] $mid '235001%' $end" | $connect
echo "$pre ARRAY['man_made', 'well', 'content', 'water'] $mid '235002%' $end" | $connect
echo "$pre ARRAY['man_made', 'petroleum_well'] $mid '235003%' $end" | $connect
echo "$pre ARRAY['landuse', 'reservoir', 'note', 'underground reservoir'] $mid '238001%' $end" | $connect
echo "$pre ARRAY['man_made', 'storage', 'content', 'silage'] $mid '244001%' $end" | $connect
echo "$pre ARRAY['man_made', 'tower', 'tower:type', 'communication'] $mid '253001%' $end" | $connect
echo "$pre ARRAY['aeroway', 'control_tower'] $mid '253002%' $end" | $connect
echo "$pre ARRAY['man_made', 'tower'] $mid '253003%' $end" | $connect
echo "$pre ARRAY['man_made', 'tower', 'tower:type', 'observation'] $mid '253004%' $end" | $connect
echo "$pre ARRAY['man_made', 'tower', 'tower:type', 'observation', 'tourism', 'lookout'] $mid '253005%' $end" | $connect
