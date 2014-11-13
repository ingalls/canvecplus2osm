echo "Extracting TO_PG"

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM to_pg WHERE code::TEXT LIKE "
end=");"
