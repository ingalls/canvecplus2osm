set -e -o pipefail
echo "Extracting HD_PT"

pre="INSERT INTO osm_pt (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM hd_pt WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep hd_pt | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['man_made', 'beacon'] $mid '125001%' $end" | $connect

echo "$pre ARRAY['waterway','dam','fixme','Unidentified manmade hydrographic feature type','area','yes'] $mid '145001%' $end" | $connect
echo "$pre ARRAY['waterway','dam','fixme','Unidentified manmade hydrographic feature type','area','yes'] $mid '145002%' $end" | $connect
echo "$pre ARRAY['waterway','dam','area','yes'] $mid '145003%' $end" | $connect
echo "$pre ARRAY['waterway','lock_gate'] $mid '145004%' $end" | $connect
echo "$pre ARRAY['leisure','slipway'] $mid '145005%' $end" | $connect
echo "$pre ARRAY['man_made','pier','mooring','yes'] $mid '145007%' $end" | $connect
echo "$pre ARRAY['man_made','pier','mooring','yes'] $mid '145008%' $end" | $connect
echo "$pre ARRAY['waterway','dock','area','yes'] $mid '145011%' $end" | $connect
echo "$pre ARRAY['waterway','waterfall'] $mid '146002%' $end" | $connect
echo "$pre ARRAY['waterway','rapids','area','yes'] $mid '146003%' $end" | $connect
echo "$pre ARRAY['natural','land'] $mid '146004%' $end" | $connect
echo "$pre ARRAY['waterway','stream','note','Disappearing stream'] $mid '146005%' $end" | $connect
echo "$pre ARRAY['historic','wreck'] $mid '146006%' $end" | $connect
echo "$pre ARRAY['highway','ford'] $mid '146007%' $end" | $connect
echo "$pre ARRAY['natural','land'] $mid '146104%' $end" | $connect
echo "$pre ARRAY['historic','wreck'] $mid '146106%' $end" | $connect

echo "  DONE"
