echo "Extracting SS_LN"

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ss_ln WHERE code::TEXT LIKE "
end=");"