echo "Extracting SS_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ss_pt WHERE code::TEXT LIKE "
end=");"
