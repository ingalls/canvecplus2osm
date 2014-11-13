echo "Extracting IC_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ic_pt WHERE code::TEXT LIKE "
end=");"

echo "$pre ARRAY['landuse', 'quarry', 'fixme', 'identify extracted resource tag value'] $mid '135003%' $end" | $connect
echo "$pre ARRAY['landuse', 'quarry', 'fixme', 'identify extracted resource tag value'] $mid '135004%' $end" | $connect
echo "$pre ARRAY['landuse', 'landfill', 'note', 'Industrial solid depot'] $mid '136002%' $end" | $connect
echo "$pre ARRAY['landuse', 'commercial', 'fixme', 'Mix of both industrial and commercial areas'] $mid '136003%' $end" | $connect
echo "$pre ARRAY['landuse', 'industrial', 'note', 'auto wrecker'] $mid '236001%' $end" | $connect
echo "$pre ARRAY['landuse', 'quarry', 'fixme', 'Identify extracted resource tag value'] $mid '260001%' $end" | $connect
