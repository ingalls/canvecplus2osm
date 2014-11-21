#/bin/bash
set -e

psql -U postgres canvec -f $(dirname $0)/osm_schema.sql

CPUNUM=$(node -e 'console.log(require("os").cpus().length);')
CPUSEQ=$(seq 0 $(node -e 'console.log(require("os").cpus().length - 1);'))
PSQL="psql -q -U postgres canvec"

parallel "echo \" SELECT insert_node(geom) FROM osm_pt WHERE (id % $CPUNUM) = {}; \" | $PSQL" ::: $CPUSEQ
parallel "echo \" SELECT insert_node((ST_DumpPoints(geom)).geom) FROM osm_ln WHERE (id % $CPUNUM) = {}; \" | $PSQL" ::: $CPUSEQ
parallel "echo \"SELECT insert_node((ST_DumpPoints(geom)).geom) FROM osm_pg; \" | $PSQL" ::: $CPUSEQ
