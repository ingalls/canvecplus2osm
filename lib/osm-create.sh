#/bin/bash
set -e

source $(dirname $0)/logger.sh
PSQL="psql -q -U postgres canvec"

log "Turn off Pset" 2
echo "\\pset pager off" | $PSQL || fail && pass

log "Clearing Tables" 2
echo "
    DROP TABLE IF EXISTS nodes;
    DROP TABLE IF EXISTS ways;
    DROP TABLE IF EXISTS relations;
" | $PSQL &>/dev/null || fail && pass


log "Loading ref_node()" 2
$PSQL -f $(dirname $0)/ref_node.sql &>/dev/null || fail && pass
log "Loading idx()" 2
$PSQL -f $(dirname $0)/ref_node.sql &>/dev/null || fail && pass


CPUNUM=$(node -e 'console.log(require("os").cpus().length);')
CPUSEQ=$(seq 0 $(node -e 'console.log(require("os").cpus().length - 1);'))

log "Creating node references" 2
echo "
    CREATE TABLE nodes AS
        (SELECT geom FROM osm_pt) UNION
        (SELECT (ST_DumpPoints(geom)).geom FROM osm_ln) UNION
        (SELECT (ST_DumpPoints(geom)).geom FROM osm_pg);

    ALTER TABLE nodes ADD COLUMN tags HSTORE;
    ALTER TABLE nodes ADD COLUMN id UNIQUE BIGINT;
    UPDATE nodes SET id = idx(geom); 
" | $PSQL || fail && pass

log "Creating Way Table" 2
echo "
    CREATE TABLE ways (
        id UNIQUE BIGINT,
        nodes BIGINT[],
        tags HSTORE
    );
" | $PSQL || fail && pass

RES="ln pg"

log "Assigning OSM tags to nodes" 2
parallel "echo \"UPDATE nodes SET tags = osm_tags FROM osm_pt WHERE ST_Equals(osm_pt.geom, nodes.geom) AND (nodes.id % $CPUNUM) = {};\" | $PSQL" ::: $CPUSEQ || fail && pass

log "Converting Line Geometry to Ways with node references" 2 
echo "
    SELECT ref_node(n.geom, n.osm_tags) FROM (SELECT (ST_Dump(ST_Union(geom))).geom, osm_tags FROM osm_ln GROUP BY osm_tags) AS n;
" | $PSQL &>/dev/null || fail && pass

log "Converting Non-Multi Polygonal Geometry to Ways with node references" 2
echo "
    SELECT ref_node(n.geom, n.osm_tags) FROM (SELECT (ST_Dump(ST_Union(geom))).geom, osm_tags FROM osm_pg GROUP BY osm_tags) AS n;
" | $PSQL &>/dev/null || fail && pass

log "Converting Multi Polygonal Area to Relations with way references" 2
#@TODO
warn
