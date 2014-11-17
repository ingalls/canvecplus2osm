set -e -o pipefail
echo "Extracting TR_LN"

#@TODO &FREEWAY, &RAMP &RECREATION need to be fixed see http://wiki.openstreetmap.org/wiki/CanVec:_Transportation_%28TR%29
#@TODO # of lanes
#@TODO surface type
#@TODO highways should have ref tag set
    #where `name:highway 55' ref=55
    #where `name:highway 55/20' ref=55;20

pre="INSERT INTO osm_ln (geom, osm_tags) ( SELECT wkb_geometry AS geom, hstore( "
mid=") AS osm_tags FROM tr_ln WHERE code::TEXT LIKE "
end=");"

connect="psql -U postgres canvec"

if [ $(echo "\d" | $connect | grep tr_ln | wc -l) = "0" ]; then
    echo "  No Features for this layer"
    exit 0
fi

echo "$pre ARRAY['railway','rail','gauge','narrow'] $mid '102001%' $end" | $connect
echo "$pre ARRAY['railway','rail','gauge','narrow'] $mid '102002%' $end" | $connect
echo "$pre ARRAY['railway','abandoned'] $mid '102003%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102004%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102005%' $end" | $connect
echo "$pre ARRAY['railway','construction','tracks','multiple'] $mid '102006%' $end" | $connect
echo "$pre ARRAY['railway','construction'] $mid '102007%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102035%' $end" | $connect
echo "$pre ARRAY['railway','rail','tracks','multiple'] $mid '102036%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102037%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102038%' $end" | $connect
echo "$pre ARRAY['railway','rail','tracks','multiple'] $mid '102039%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102040%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes'] $mid '102041%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes','tracks','multiple'] $mid '102042%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes'] $mid '102043%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes'] $mid '102044%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes','tracks','multiple'] $mid '102045%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes'] $mid '102046%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes'] $mid '102047%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes','tracks','multiple'] $mid '102048%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes'] $mid '102049%' $end" | $connect
echo "$pre ARRAY['railway','construction','tracks','multiple','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102050%' $end" | $connect
echo "$pre ARRAY['railway','construction','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102051%' $end" | $connect
echo "$pre ARRAY['railway','rail','tracks','multiple','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102052%' $end" | $connect
echo "$pre ARRAY['railway','rail','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102053%' $end" | $connect
echo "$pre ARRAY['railway','rail','tracks','multiple','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102054%' $end" | $connect
echo "$pre ARRAY['railway','rail','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102055%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes','tracks','multiple','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102056%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102057%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes','tracks','multiple','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102058%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102059%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes','tracks','multiple','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102060%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102061%' $end" | $connect
echo "$pre ARRAY['railway','disused','gauge','narrow'] $mid '102062%' $end" | $connect
echo "$pre ARRAY['railway','rail','gauge','narrow'] $mid '102063%' $end" | $connect
echo "$pre ARRAY['railway','rail','gauge','narrow'] $mid '102064%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102065%' $end" | $connect
echo "$pre ARRAY['railway','disused'] $mid '102066%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102067%' $end" | $connect
echo "$pre ARRAY['railway','construction','tracks','multiple'] $mid '102068%' $end" | $connect
echo "$pre ARRAY['railway','construction'] $mid '102069%' $end" | $connect
echo "$pre ARRAY['railway','rail','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102070%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102071%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes','fixme','Rail is one of monorail-tram-funicular-subway-light_rail'] $mid '102072%' $end" | $connect
echo "$pre ARRAY['railway','adandoned'] $mid '102088%' $end" | $connect
echo "$pre ARRAY['railway','abandoned'] $mid '102089%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','tracks','multiple'] $mid '102090%' $end" | $connect
echo "$pre ARRAY['railway','abandoned'] $mid '102091%' $end" | $connect
echo "$pre ARRAY['railway','abandoned'] $mid '102092%' $end" | $connect
echo "$pre ARRAY['railway','abandoned'] $mid '102093%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','tracks','multiple'] $mid '102094%' $end" | $connect
echo "$pre ARRAY['railway','abandoned'] $mid '102095%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','snowshed','yes'] $mid '102096%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','showshed','yes'] $mid '102097%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','snowshed','yes','tracks','multiple'] $mid '102098%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','showshed','yes'] $mid '102099%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','bridge','yes'] $mid '102100%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','bridge','yes'] $mid '102101%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','bridge','yes','tracks','multiple'] $mid '102102%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','bridge','yes'] $mid '102103%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','tunnel','yes'] $mid '102104%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','tunnel','yes'] $mid '102105%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','tunnel','yes','tracks','multiple'] $mid '102106%' $end" | $connect
echo "$pre ARRAY['railway','abandoned','tunnel','yes'] $mid '102107%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102108%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102109%' $end" | $connect
echo "$pre ARRAY['railway','rail','tracks','multiple'] $mid '102110%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102111%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102112%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102113%' $end" | $connect
echo "$pre ARRAY['railway','rail','tracks','multiple'] $mid '102114%' $end" | $connect
echo "$pre ARRAY['railway','rail'] $mid '102115%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes'] $mid '102116%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes'] $mid '102117%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes','tracks','multiple'] $mid '102118%' $end" | $connect
echo "$pre ARRAY['railway','rail','snowshed','yes'] $mid '102119%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes'] $mid '102120%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes'] $mid '102121%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes','tracks','multiple'] $mid '102122%' $end" | $connect
echo "$pre ARRAY['railway','rail','bridge','yes'] $mid '102123%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes'] $mid '102124%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes'] $mid '102125%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes','tracks','multiple'] $mid '102126%' $end" | $connect
echo "$pre ARRAY['railway','rail','tunnel','yes'] $mid '102127%' $end" | $connect
echo "$pre ARRAY['route','ferry','type','route','motorcar','yes'] $mid '175001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','secondary','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','tertiary','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','primary','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','gravel','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&FREEWAY','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','residential','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RAMP','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','covered','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','moveable','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','bridge','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','embankment','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','snowshed','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','paved','tunnel','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','covered','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','moveable','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','bridge','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','embankment','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','snowshed','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','unclassified','surface','dirt','tunnel','yes','psv','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','&RECREATION','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','paved','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','covered'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','moveable'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','embankment','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','snowshed','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','service','surface','dirt','tunnel','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','track','surface','unpaved','date_on','winter','bridge','yes'] $mid '176001%' $end" | $connect
echo "$pre ARRAY['highway','track','surface','unpaved','date_on','winter'] $mid '176001%' $end" | $connect


echo "  DONE"
