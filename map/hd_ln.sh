set -e -o pipefail

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM hd_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep hd_ln | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['waterway','dam','fixme','Unidentified manmade hydrographic feature type','area','yes'] $mid '145001%' $end" | $connect
echo "$pre ARRAY['waterway','dam','fixme','Unidentified manmade hydrographic feature type','area','yes'] $mid '145002%' $end" | $connect
echo "$pre ARRAY['waterway','dam','area','yes'] $mid '145003%' $end" | $connect
echo "$pre ARRAY['waterway','lock_gate'] $mid '145004%' $end" | $connect
echo "$pre ARRAY['man_made','pier','mooring','yes'] $mid '145007%' $end" | $connect
echo "$pre ARRAY['man_made','pier','mooring','yes'] $mid '145008%' $end" | $connect
echo "$pre ARRAY['man_made','breakwater'] $mid '145009%' $end" | $connect
echo "$pre ARRAY['man_made','dyke'] $mid '145010%' $end" | $connect
echo "$pre ARRAY['waterway','dock','area','yes'] $mid '145011%' $end" | $connect
echo "$pre ARRAY['man_made','breakwater'] $mid '145109%' $end" | $connect
echo "$pre ARRAY['waterway','waterfall'] $mid '146002%' $end" | $connect
echo "$pre ARRAY['waterway','rapids','area','yes'] $mid '146003%' $end" | $connect
echo "$pre ARRAY['highway','ford'] $mid '146007%' $end" | $connect
echo "$pre ARRAY['waterway','stream','fixme','watercourse type','water','intermittent'] $mid '147011%' $end" | $connect
echo "$pre ARRAY['waterway','stream','fixme','watercourse type'] $mid '147011%' $end" | $connect
echo "$pre ARRAY['waterway','stream','fixme','watercourse type'] $mid '147011%' $end" | $connect
echo "$pre ARRAY['waterway','canal','water','intermittent'] $mid '147012%' $end" | $connect
echo "$pre ARRAY['waterway','canal'] $mid '147012%' $end" | $connect
echo "$pre ARRAY['waterway','canal'] $mid '147012%' $end" | $connect
echo "$pre ARRAY['man_made','pipeline','type','water','water','intermittent'] $mid '147013%' $end" | $connect
echo "$pre ARRAY['man_made','pipeline','type','water'] $mid '147013%' $end" | $connect
echo "$pre ARRAY['man_made','pipeline','type','water'] $mid '147013%' $end" | $connect
echo "$pre ARRAY['waterway','ditch','water','intermittent'] $mid '147014%' $end" | $connect
echo "$pre ARRAY['waterway','ditch'] $mid '147014%' $end" | $connect
echo "$pre ARRAY['waterway','ditch'] $mid '147014%' $end" | $connect
echo "$pre ARRAY['waterway','stream','water','intermittent'] $mid '147017%' $end" | $connect
echo "$pre ARRAY['waterway','stream'] $mid '147017%' $end" | $connect
echo "$pre ARRAY['waterway','stream'] $mid '147017%' $end" | $connect
echo "$pre ARRAY['waterway','stream','water','intermittent'] $mid '147018%' $end" | $connect
echo "$pre ARRAY['waterway','stream'] $mid '147018%' $end" | $connect
echo "$pre ARRAY['waterway','stream'] $mid '147018%' $end" | $connect

