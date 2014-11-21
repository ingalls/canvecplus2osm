#!/bin/bash

echo "Canvec Import v0.1.0"

set -e -o pipefail
TMP="$(dirname $0)/tmp"
CACHE="$(dirname $0)/cache"

#colours
green="\e[32m"
reset="\e[39m"
red="\e[31m"
yellow="\e[33m"

mkdir -p $TMP
mkdir -p $CACHE

log() {
    spaces=$(printf %${2}s)
    if [ "$3" = "head" ]; then
        echo "$spaces- $1"
    else
        echo -n "$spaces- $1"
    fi
}

pass() {
    echo -e " [${green}done${reset}]"
}
fail() {
    echo -e " [${red}fail${reset}]"
    exit 1
}

connect="psql -q -U postgres canvec"

log "Is parllel installed?" 0
type parallel > /dev/null 2>&1 || fail && pass

log "Is ogr2ogr installed?" 0
type ogr2ogr > /dev/null 2>&1 || fail && pass

log "Is psql installed?" 0
type psql > /dev/null 2>&1 || fail && pass

log "Is wget installed?" 0
type wget > /dev/null 2>&1 || fail && pass

log "Is database empty?" 0
if [ $(echo "\d" | psql -U postgres canvec | grep canvec_tmp | wc -l) != "0" ]; then
    fail
fi
pass

log "Caching FTP Lists" 0 "head"

#Cache/Read areas
if [ -e $CACHE/areas ]; then
    log "Reading Areas" 2
    areas=$(<$CACHE/areas)
    pass
else
    log "Caching Areas " 2
    areas=$( wget -qO- ftp://ftp2.cits.rncan.gc.ca/pub/canvec+/shp/ | grep "Directory" | sed '/^$/d;s/[[:blank:]]//g' | sed 's/^.*Directory.*">//' | sed 's/\/<\/a>//' )
    echo $areas > $CACHE/areas
    pass
fi

#Cache/Read subareas
log "Caching Sub Areas" 2 "head"
for area in $areas; do
    if [ ! -e $CACHE/$area ] || [ ! -e $CACHE/$area-en ] || [ ! -e $CACHE/$area-fr ]; then
        log "Caching $area" 4
        wget -qO- ftp://ftp2.cits.rncan.gc.ca/pub/canvec+/shp/$area/ | grep "File" | sed '/^$/d;s/[[:blank:]]//g' | sed 's/^.*File<ahref="//' | sed 's/">.*$//' > $CACHE/$area
        wget -qO- ftp://ftp2.cits.rncan.gc.ca/pub/geobase/official/cgn/250k_shp_eng/$area/ | grep "File" | sed '/^$/d;s/[[:blank:]]//g' | sed 's/^.*File<ahref="//' | sed 's/">.*$//' > $CACHE/$area-en || true
        wget -qO- ftp://ftp2.cits.rncan.gc.ca/pub/geobase/official/cgn/250k_shp_fra/$area/ | grep "File" | sed '/^$/d;s/[[:blank:]]//g' | sed 's/^.*File<ahref="//' | sed 's/">.*$//' > $CACHE/$area-fr || true
        pass
    fi
done
log "All Sub Areas Cached" 4 
pass

for area in $areas; do
    log "Processing Area $area" 0 "head"
    subAreas=$(<$CACHE/$area)
    log "Downloading CanVec+" 2
    parallel "wget -nc -q {} -P $TMP" ::: <$CACHE/$area && pass
    log "Downloading CGN-en" 2
    parallel "wget -nc -q {} -P $TMP" ::: <$CACHE/$area-en && pass
    log "Downloading CGN-fr" 2
    parallel "wget -nc -q {} -P $TMP" ::: <$CACHE/$area-fr && pass

    log "Creating OSM Tables" 2
    echo "
        BEGIN;
        CREATE TABLE osm_pt (osm_tags HSTORE, id SERIAL);
        SELECT AddGeometryColumn('osm_pt', 'geom', '4326', 'POINT', 2);
        CREATE TABLE osm_ln (osm_tags HSTORE, id SERIAL);
        SELECT AddGeometryColumn('osm_ln', 'geom', '4326', 'LINESTRING', 2);
        CREATE TABLE osm_pg (osm_tags HSTORE, id SERIAL);
        SELECT AddGeometryColumn('osm_pg', 'geom', '4326', 'MULTIPOLYGON', 2);
        COMMIT;        
    " | $connect 1>/dev/null || fail && pass

    for sub in $subAreas; do
        log "Processing Sub Area canvec_$(echo $sub | sed 's/ftp.*canvec_//' )" 2 "head"
        subdir=$( echo "$sub" | sed 's/_shp.zip//' | sed 's/^.*canvec_//')
        mkdir -p $TMP/$subdir

        log "Unzipping CanVec+ $subdir" 4
        unzip -qq -o $TMP/canvec_${subdir}_shp.zip -d $TMP/$subdir || fail && pass
        log "Unzipping CGN-fr $subdir" 4
        unzip -qq -o $TMP/cgn_${subdir,,}_shp_fra.zip -d $TMP/$subdir 2>/dev/null || fail && pass
        log "Unzipping CGN-en $subdir" 4
        unzip -qq -o $TMP/cgn_${subdir,,}_shp_eng.zip -d $TMP/$subdir 2>/dev/null || fail && pass

        log "Importing CGN-en" 4
        ogr2ogr -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln cgn_eng PG:"host='localhost' user='postgres' dbname='canvec'" $TMP/$subdir/${subdir,,}_geoname.shp || fail && pass
        log "Importing CGN-fr" 4     
        ogr2ogr -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln cgn_fra PG:"host='localhost' user='postgres' dbname='canvec'" $TMP/$subdir/${subdir,,}_toponyme.shp || fail && pass
        
        for layer in bs en fo hd ic li lx ss to tr ve; do
            log "Retrieving ${layer} From $TMP/$subdir" 4 "head"
            layer_pt=$( ls $TMP/$subdir/${layer}_???????_0.shp 2>/dev/null || echo "" )
            layer_ln=$( ls $TMP/$subdir/${layer}_???????_1.shp 2>/dev/null || echo "" )
            layer_pg=$( ls $TMP/$subdir/${layer}_???????_2.shp 2>/dev/null || echo "" )
            for layertmp in $layer_pt; do
                log "Importing $layer pt" 6
                ogr2ogr -append -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln ${layer}_pt PG:"host='localhost' user='postgres' dbname='canvec'" $layertmp || fail && pass
            done
            for layertmp in $layer_ln; do
                log "Importing $layer ln" 6
                ogr2ogr -append -t_srs EPSG:4326 -f "PostgreSQL" -nlt LINESTRING -nln ${layer}_ln PG:"host='localhost' user='postgres' dbname='canvec'" $layertmp || fail && pass
            done
            for layertmp in $layer_pg; do
                log "Importing $layer pg" 6
                ogr2ogr -append -t_srs EPSG:4326 -f "PostgreSQL" -nlt PROMOTE_TO_MULTI -nln ${layer}_pg PG:"host='localhost' user='postgres' dbname='canvec'" $layertmp || fail && pass
            done

            log "Coverting ${layer}_pt to OSM tags" 6
            ./map/${layer}_pt.sh || fail && pass
            log "Coverting ${layer}_ln to OSM tags" 6
            ./map/${layer}_ln.sh || fail && pass
            log "Coverting ${layer}_pg to OSM tags" 6
            ./map/${layer}_pg.sh || fail && pass
        
        done


        log "Dropping original data" 4 "head"
        for DB in $( echo "\d" | psql -U postgres canvec | grep "| .._.. " | sed -e 's/ public . //' -e 's/  .*//' ); do
            log "Dropping $DB" 6
            echo "
                DROP TABLE $DB;
            " | psql -q -U postgres canvec || fail && pass
        done
        
        log "Dropping MISC tables" 6
        echo "
            DROP TABLE IF EXISTS cgn_eng;
            DROP TABLE IF EXISTS cgn_fra;
            DROP TABLE IF EXISTS tmp_to;
        " | psql -q -U postgres canvec || fail && pass

        log "Outputting to OSM" 6 "head"
        #POSTGRES=>OSM script

        echo "
            DROP TABLE IF EXISTS osm_pg;
            DROP TABLE IF EXISTS osm_ln;
            DROP TABLE IF EXISTS osm_pt;
        " | psql -q -U postgres canvec
    done
    exit
done
