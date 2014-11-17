#!/bin/bash

set -e -o pipefail
TMP="$(dirname $0)/tmp"
mkdir -p $TMP
connect="psql -U postgres canvec"

if [ $(echo "\d" | psql -U postgres canvec | grep canvec_tmp | wc -l) != "0" ]; then
    echo "Database not empty! Run ./setup.sh"
    exit 1
fi

area=$( wget -qO- ftp://ftp2.cits.rncan.gc.ca/pub/canvec+/shp/ | grep "</a>" | sed '/^$/d;s/[[:blank:]]//g' | sed 's/^2014.*">//' | sed 's/\/<\/a>//' )

for file in $area; do
    wget -nH --cut-dirs=100 -m ftp://ftp2.cits.rncan.gc.ca/pub/canvec+/shp/$file/* -P $TMP
    subAreas=$( ls $TMP )
    wget -nH --cut-dirs=100 -m ftp://ftp2.cits.rncan.gc.ca/pub/geobase/official/cgn/250k_shp_eng/$file/* -P $TMP
    wget -nH --cut-dirs=100 -m ftp://ftp2.cits.rncan.gc.ca/pub/geobase/official/cgn/250k_shp_fra/$file/* -P $TMP

    for sub in $subAreas; do
        subdir=$( echo "$sub" | sed 's/_shp.zip//' | sed 's/canvec_//')
        mkdir $TMP/$subdir
        unzip -o $TMP/$sub -d $TMP/$subdir
        unzip -o $TMP/cgn_${subdir,,}_shp_fra.zip -d $TMP/$subdir
        unzip -o $TMP/cgn_${subdir,,}_shp_eng.zip -d $TMP/$subdir
        
        rm $TMP/$sub
        rm $TMP/cgn_*

        ogr2ogr -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln cgn_eng PG:"host='localhost' user='postgres' dbname='canvec'" $TMP/$subdir/001k_geoname.shp
        ogr2ogr -t_srs EPSG:4326 -f "PostgreSQL" -nlt POINT -nln cgn_fra PG:"host='localhost' user='postgres' dbname='canvec'" $TMP/$subdir/001k_toponyme.shp
        
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
        done
                
        echo "
            CREATE TABLE osm_pt (osm_tags HSTORE, id SERIAL);
            SELECT AddGeometryColumn('osm_pt', 'geom', '4326', 'POINT', 2);
        " | psql -U postgres canvec

        echo "
            CREATE TABLE osm_ln (osm_tags HSTORE, id SERIAL);
            SELECT AddGeometryColumn('osm_ln', 'geom', '4326', 'LINESTRING', 2);
        " | psql -U postgres canvec

        echo "
            CREATE TABLE osm_pg (osm_tags HSTORE, id SERIAL);
            SELECT AddGeometryColumn('osm_pg', 'geom', '4326', 'MULTIPOLYGON', 2);
        " | psql -U postgres canvec

        #source ./map/${layer}_pt.sh
        #source ./map/${layer}_ln.sh
        #source ./map/${layer}_pg.sh
        exit 0
    done
done


