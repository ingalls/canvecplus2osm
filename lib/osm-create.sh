#/bin/bash
set -e

psql -q -U postgres canvec -f $(dirname $0)/osm_schema.sql

CPUNUM=$(node -e 'console.log(require("os").cpus().length);')
CPUSEQ=$(seq 0 $(node -e 'console.log(require("os").cpus().length - 1);'))
PSQL="psql -q -U postgres canvec"

echo "
    CREATE TABLE nodes AS
        (SELECT geom FROM osm_pt) UNION
        (SELECT (ST_DumpPoints(geom)).geom FROM osm_ln) UNION
        (SELECT (ST_DumpPoints(geom)).geom FROM osm_pg);

    ALTER TABLE nodes ADD COLUMN tags HSTORE;
    CREATE SEQUENCE node_ids_seq;
    ALTER TABLE nodes ADD COLUMN id INTEGER NOT NULL DEFAULT nextval('node_ids_seq');
" | $PSQL

RES="ln pg"
echo "CREATE TABLE itsec_pt AS (SELECT geom FROM nodes) INTERSECT (SELECT geom FROM osm_pt); " | $PSQL
parallel " echo \"CREATE TABLE itsec_{} AS (SELECT geom FROM nodes) INTERSECT (SELECT (ST_DumpPoints(geom)).geom FROM osm_{}); \" | $PSQL " ::: $RES

parallel "echo \"UPDATE nodes SET tags = osm_tags FROM osm_pt WHERE ST_Equals(osm_pt.geom, nodes.geom) AND (nodes.id % $CPUNUM) = {};\" | $PSQL" ::: $CPUSEQ
