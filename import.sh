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

connect="psql -U postgres canvec"

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
    parallel "wget -q {} -P $TMP" ::: <$CACHE/$area && pass
    log "Downloading CGN-en" 2
    parallel "wget -q {} -P $TMP" ::: <$CACHE/$area-en && pass
    log "Downloading CGN-fr" 2
    parallel "wget -q {} -p $TMP" ::: <$CACHE/$area-fr && pass

    for sub in $subAreas; do
	log "Processing Sub Area $sub" 2 "head"
        subdir=$( echo "$sub" | sed 's/_shp.zip//' | sed 's/canvec_//')
        mkdir $TMP/$subdir
	
	log "Unzipping CanVec+" 4
        unzip -qq -o $TMP/$sub -d $TMP/$subdir || fail && pass
	log "Unzipping CGN-fr" 4
        unzip -qq -o $TMP/cgn_${subdir,,}_shp_fra.zip -d $TMP/$subdir || fail && pass
	log "Unzipping CGN-en" 4
        unzip -qq -o $TMP/cgn_${subdir,,}_shp_eng.zip -d $TMP/$subdir || fail && pass
        
        rm $TMP/$sub
        rm $TMP/cgn_*

	log "Importing CGN-en" 4
        ogr2ogr -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln cgn_eng PG:"host='localhost' user='postgres' dbname='canvec'" $TMP/$subdir/001k_geoname.shp || fail && pass
	log "Importing CGN-fr" 4     
	ogr2ogr -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln cgn_fra PG:"host='localhost' user='postgres' dbname='canvec'" $TMP/$subdir/001k_toponyme.shp || fail && pass
        
       	echo "
            BEGIN;
            CREATE TABLE osm_pt (osm_tags HSTORE, id SERIAL);
            SELECT AddGeometryColumn('osm_pt', 'geom', '4326', 'POINT', 2);
            CREATE TABLE osm_ln (osm_tags HSTORE, id SERIAL);
            SELECT AddGeometryColumn('osm_ln', 'geom', '4326', 'LINESTRING', 2);
            CREATE TABLE osm_pg (osm_tags HSTORE, id SERIAL);
            SELECT AddGeometryColumn('osm_pg', 'geom', '4326', 'MULTIPOLYGON', 2);
            COMMIT;        
        " | psql -U postgres canvec

        for layer in bs en fo hd ic li lx ss to tr ve; do
            echo "Retrieving ${layer} From $TMP/$subdir"
            layer_pt=$( ls $TMP/$subdir/${layer}_???????_0.shp 2>/dev/null || echo "" )
            layer_ln=$( ls $TMP/$subdir/${layer}_???????_1.shp 2>/dev/null || echo "" )
            layer_pg=$( ls $TMP/$subdir/${layer}_???????_2.shp 2>/dev/null || echo "" )
            for layertmp in $layer_pt; do
                echo "COPYING $layer_pt"
                ogr2ogr -append -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln ${layer}_pt PG:"host='localhost' user='postgres' dbname='canvec'" $layertmp
            done
            for layertmp in $layer_ln; do
                echo "COPYING $layer_ln"
                ogr2ogr -append -t_srs EPSG:4326 -f "PostgreSQL" -nlt LINESTRING -nln ${layer}_ln PG:"host='localhost' user='postgres' dbname='canvec'" $layertmp
            done
            for layertmp in $layer_pg; do
                echo "COPYING $layer_pg"
                ogr2ogr -append -t_srs EPSG:4326 -f "PostgreSQL" -nlt PROMOTE_TO_MULTI -nln ${layer}_pg PG:"host='localhost' user='postgres' dbname='canvec'" $layertmp
            done
	
		    ./map/${layer}_pt.sh
            ./map/${layer}_ln.sh
            ./map/${layer}_pg.sh
        done
    done
done
