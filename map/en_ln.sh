set -e -o pipefail

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM en_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep en_ln | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['man_made', 'pipeline', 'location', 'underground', 'type', 'any_substance'] $mid '1180081' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'underground', 'type', 'oil'] $mid '1180061' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'overground', 'type', 'any_substance'] $mid '1180071' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'overground', 'type', 'any_substance'] $mid '1180031' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'underground', 'type', 'natural_gas'] $mid '1180021' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'underground', 'type', 'any_substance'] $mid '1180041' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'overground', 'type', 'natural_gas'] $mid '1180011' $end" | $connect
echo "$pre ARRAY['man_made', 'pipeline', 'location', 'overground', 'type', 'oil'] $mid '1180051' $end" | $connect
echo "$pre ARRAY['power', 'line'] $mid '1120011' $end" | $connect
echo "$pre ARRAY['power', 'line', 'location', 'underground'] $mid '1120021' $end" | $connect

