
--Takes values from: 
--  osm_pg (polygons)
--  osm_ln (lines)
--  osm_pt (points)
--Ands reduces them into a Full Integration Model
--This means that all ways/nodes are shared wherever possible

\pset pager off

--DROP Previous Tables
DROP TABLE IF EXISTS nodes;
DROP SEQUENCE IF EXISTS node_ids_seq;
DROP TABLE IF EXISTS ways;
DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS itsec_ln;
DROP TABLE IF EXISTS itsec_pg;
DROP TABLE IF EXISTS itsec_pt;

CREATE TABLE ways (
    id      SERIAL PRIMARY KEY,
    nodes   BIGINT[],
    tags    HSTORE
);

CREATE TABLE relations (
    id      SERIAL PRIMARY KEY,
    tags    HSTORE
);

