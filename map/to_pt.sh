set -e -o pipefail

connect="psql -q -U postgres canvec"

if [ $(echo "\d" | $connect | grep to_pt | wc -l) = "0" ]; then
    exit 0
fi

echo "
    CREATE TABLE tmp_to AS 
        SELECT
            eng.geoname AS en,
            fra.nomgeo AS fr,
            eng.conciscode AS code,
            eng.wkb_geometry AS geom
        FROM cgn_eng AS eng 
            INNER JOIN cgn_fra AS fra ON (ST_Equals(eng.wkb_geometry, fra.wkb_geometry));

    ALTER TABLE tmp_to ADD COLUMN bi TEXT;

    INSERT INTO tmp_to (geom, bi, en, fr)
        SELECT
            wkb_geometry, 
            'test',
            nameen, 
            namefr
        FROM
            to_pt AS pt
        WHERE 
            nameen NOT IN (
                SELECT en 
                FROM tmp_to) AND
            namefr NOT IN (
                SELECT fr
                FROM tmp_to
            );

    UPDATE tmp_to 
        SET (bi, en, fr) = (en, NULL, NULL)
        WHERE en = fr;
        
    UPDATE tmp_to
        SET bi = en
        WHERE bi IS NULL;
" | $connect

BAY="'natural', 'bay'"
BCH="'natural', 'beach'"
CAPE="'natural', 'cliff'"
CAVE="'natural','cave_entrance'"
CHAN="'natural','water'"
CITY="'place','city'"
CLF="'natural','cliff'"
CRAT="'natural','volcano'"
FALL="'natural','water'"
FOR="'natural','wood'"
GEOG="'place','locality', 'fixme', 'Place type may not be valid'"
GLAC="'natural','glacier'"
HAM="'place','hamlet'"
IR="'place','locality', 'fixme', 'Place type may not be valid'"
ISL="'place','island'"
LAKE="'natural','lake'"
MIL="'landuse','military'"
MISC="'place','suburb', 'fixme', 'Place type may not be valid'"
MTN="'natural','peak'"
MUN1="'place','suburb', 'fixme', 'Place type may not be valid'"
MUN2="'place','suburb', 'fixme', 'Place type may not be valid'"
PARK="'leisure','park'"
PLN="'place','locality'"
RAP="'natural','water'"
RIV="'natural','water'"
RIVF="'natural','water', 'fixme', 'Feature may not be valid'"
SEA="'natural','water'"
SEAF="'natural','water'"
SEAU="'natural','water', 'fixme', 'Feature may not be valid'"
SHL="'natural','water'"
SPRG="'natural','spring'"
TOWN="'place','town'"
UNP="'place','locality', 'fixme', 'Place type may not be valid'"
VALL="'place','locality'"
VEGL="'natural','scrub'"
VILG="'place','village'"

for CODE in BAY BCH CAPE CAVE CHAN CITY CLF CRAT FALL FOR GEOG GLAC HAM IR ISL LAKE MIL MISC\
    MTN MUN1 MUN2 PARK PLN RAP RIV RIVF SEA SEAF SEAU SHL SPRG TOWN UNP VALL VEGL VILG; do

    eval TAG=\$$CODE

    echo "
        INSERT INTO osm_pt (geom, osm_tags) (
            SELECT
                geom,
                CASE
                    WHEN bi IS NOT NULL AND en IS NULL AND fr IS NULL THEN hstore(ARRAY['name', bi, $TAG])
                    WHEN bi IS NOT NULL AND en IS NOT NULL AND fr IS NOT NULL THEN hstore(ARRAY['name', bi, 'name:en', en, 'name:fr', fr, $TAG])
                END
            FROM tmp_to
            WHERE code = '$CODE');
    " | $connect
done

