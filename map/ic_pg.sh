set -e -o pipefail

pre="INSERT INTO osm_pg (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM ic_pg WHERE code::TEXT LIKE "
end=");"

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep ic_pg | wc -l) = "0" ]; then
    exit 0
fi

echo "$pre ARRAY['landuse', 'quarry', 'resource', 'aggregate'] $mid '135001%' $end" | $connect
echo "$pre ARRAY['landuse', 'quarry', 'resource', 'aggregate'] $mid '135002%' $end" | $connect
echo "$pre ARRAY['landuse', 'quarry', 'fixme', 'identify extracted resource tag value'] $mid '135003%' $end" | $connect
echo "$pre ARRAY['landuse', 'quarry', 'fixme', 'identify extracted resource tag value'] $mid '135004%' $end" | $connect
echo "$pre ARRAY['landuse', 'quarry', 'resource', 'peat'] $mid '135005%' $end" | $connect
echo "$pre ARRAY['landuse', 'landfill', 'note', 'domestic landfill'] $mid '136001%' $end" | $connect
echo "$pre ARRAY['landuse', 'landfill', 'note', 'Industrial solid depot'] $mid '136002%' $end" | $connect
echo "$pre ARRAY['landuse', 'commercial', 'fixme', 'Mix of both industrial and commercial areas'] $mid '136003%' $end" | $connect
echo "$pre ARRAY['landuse', 'industrial', 'note', 'Lumber yard'] $mid '211001%' $end" | $connect

