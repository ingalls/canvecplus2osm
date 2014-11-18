set -e -o pipefail

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM hd_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep hd_pg | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['building', 'yes'] $mid '201001%' $end" | $connect

echo "$pre ARRAY['natural','glacier'] $mid '114003%' $end" | $connect
echo "$pre ARRAY['waterway','dam','fixme','Unidentified manmade hydrographic feature type','area','yes'] $mid '145001%' $end" | $connect
echo "$pre ARRAY['waterway','dam','fixme','Unidentified manmade hydrographic feature type','area','yes'] $mid '145002%' $end" | $connect
echo "$pre ARRAY['waterway','dam','area','yes'] $mid '145003%' $end" | $connect
echo "$pre ARRAY['man_made','pier','mooring','yes'] $mid '145007%' $end" | $connect
echo "$pre ARRAY['man_made','pier','mooring','yes'] $mid '145008%' $end" | $connect
echo "$pre ARRAY['man_made','breakwater'] $mid '145009%' $end" | $connect
echo "$pre ARRAY['waterway','dock','area','yes'] $mid '145011%' $end" | $connect
echo "$pre ARRAY['man_made','breakwater'] $mid '145109%' $end" | $connect
echo "$pre ARRAY['waterway','rapids','area','yes'] $mid '146003%' $end" | $connect
echo "$pre ARRAY['natural','reef','area','yes'] $mid '146009%' $end" | $connect
echo "$pre ARRAY['natural','reef'] $mid '146109%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148126%' $end" | $connect
echo "$pre ARRAY['natural','water','fixme','watercourse type'] $mid '148129%' $end" | $connect
echo "$pre ARRAY['natural','water','fixme','add canal as route relation'] $mid '148130%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148131%' $end" | $connect
echo "$pre ARRAY['landuse','reservoir'] $mid '148132%' $end" | $connect
echo "$pre ARRAY['landuse','basin'] $mid '148133%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148134%' $end" | $connect
echo "$pre ARRAY['waterway','riverbank','area','yes'] $mid '148136%' $end" | $connect
echo "$pre ARRAY['waterway','riverbank','area','yes'] $mid '148137%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148138%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148139%' $end" | $connect
echo "$pre ARRAY['natural','coastline'] $mid '148140%' $end" | $connect
echo "$pre ARRAY['natural','water','water','intermittent'] $mid '148226%' $end" | $connect
echo "$pre ARRAY['natural','water','fixme','watercourse type','water','intermittent'] $mid '148229%' $end" | $connect
echo "$pre ARRAY['natural','water','fixme','add canal as route relation','water','intermittent'] $mid '148230%' $end" | $connect
echo "$pre ARRAY['natural','water','water','intermittent'] $mid '148231%' $end" | $connect
echo "$pre ARRAY['landuse','reservoir','water','intermittent'] $mid '148232%' $end" | $connect
echo "$pre ARRAY['landuse','basin','water','intermittent'] $mid '148233%' $end" | $connect
echo "$pre ARRAY['natural','water','water','intermittent'] $mid '148234%' $end" | $connect
echo "$pre ARRAY['waterway','riverbank','water','tidal','area','yes'] $mid '148236%' $end" | $connect
echo "$pre ARRAY['waterway','riverbank','water','intermittent','area','yes'] $mid '148237%' $end" | $connect
echo "$pre ARRAY['natural','water','water','intermittent'] $mid '148238%' $end" | $connect
echo "$pre ARRAY['natural','water','water','intermittent'] $mid '148239%' $end" | $connect
echo "$pre ARRAY['natural','coastline','water','intermittent'] $mid '148240%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148326%' $end" | $connect
echo "$pre ARRAY['natural','water','fixme','watercourse type'] $mid '148329%' $end" | $connect
echo "$pre ARRAY['natural','water','fixme','add canal as route relation'] $mid '148330%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148331%' $end" | $connect
echo "$pre ARRAY['landuse','reservoir'] $mid '148332%' $end" | $connect
echo "$pre ARRAY['landuse','basin'] $mid '148333%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148334%' $end" | $connect
echo "$pre ARRAY['waterway','riverbank','area','yes'] $mid '148336%' $end" | $connect
echo "$pre ARRAY['waterway','riverbank','area','yes'] $mid '148337%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148338%' $end" | $connect
echo "$pre ARRAY['natural','water'] $mid '148339%' $end" | $connect
echo "$pre ARRAY['natural','coastline'] $mid '148340%' $end" | $connect
echo "$pre ARRAY['natural','land'] $mid '149001%' $end" | $connect
echo "$pre ARRAY['natural','land'] $mid '149002%' $end" | $connect
echo "$pre ARRAY['natural','land'] $mid '149003%' $end" | $connect

