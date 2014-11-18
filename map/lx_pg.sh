set -e -o pipefail

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM lx_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep lx_pg | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['amenity', 'cinema', 'foot', 'no'] $mid '207001%' $end" | $connect
echo "$pre ARRAY['historic', 'ruins'] $mid '240001%' $end" | $connect
echo "$pre ARRAY['landuse', 'cemetery'] $mid '100003%' $end" | $connect
echo "$pre ARRAY['leisure', 'garden'] $mid '220001%' $end" | $connect
echo "$pre ARRAY['leisure', 'golf_course', 'sport', 'golf'] $mid '100008%' $end" | $connect
echo "$pre ARRAY['leisure', 'golf_driving_range'] $mid '250001%' $end" | $connect
echo "$pre ARRAY['leisure', 'park'] $mid '227001%' $end" | $connect
echo "$pre ARRAY['leisure', 'park', 'note', 'Exhibition ground'] $mid '251002%' $end" | $connect
echo "$pre ARRAY['leisure', 'park', 'note', 'Fairground exhibition ground'] $mid '251001%' $end" | $connect
echo "$pre ARRAY['leisure', 'stadium'] $mid '246001%' $end" | $connect
echo "$pre ARRAY['leisure', 'track', 'fixme', 'sport type is not known'] $mid '100007%' $end" | $connect
echo "$pre ARRAY['tourism', 'attraction', 'historic', 'yes'] $mid '100004%' $end" | $connect
echo "$pre ARRAY['tourism', 'camp_site'] $mid '248001%' $end" | $connect
echo "$pre ARRAY['tourism', 'picnic_site'] $mid '249001%' $end" | $connect
echo "$pre ARRAY['tourism', 'theme_park'] $mid '226001%' $end" | $connect
echo "$pre ARRAY['tourism', 'viewpoint'] $mid '100001%' $end" | $connect
echo "$pre ARRAY['tourism', 'zoo'] $mid '256001%' $end" | $connect

