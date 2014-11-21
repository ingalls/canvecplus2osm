
--Takes values from: 
--  osm_pg (polygons)
--  osm_ln (lines)
--  osm_pt (points)
--Ands reduces them into a Full Integration Model
--This means that all ways/nodes are shared wherever possible

\pset pager off

--DROP Previous Tables
DROP TABLE IF EXISTS nodes;
DROP TABLE IF EXISTS ways;
DROP TABLE IF EXISTS relations;

CREATE TABLE nodes (
    id      SERIAL PRIMARY KEY,
    node    GEOMETRY(Point, 4326) UNIQUE,
    tags    HSTORE
);

CREATE INDEX node_gidx ON nodes USING GIST (node);

CREATE TABLE ways (
    id      SERIAL PRIMARY KEY,
    nodes   integer[],
    tags    HSTORE
);

CREATE TABLE relations (
    id      SERIAL PRIMARY KEY,
    tags    HSTORE
);

CREATE OR REPLACE FUNCTION insert_node (newnode GEOMETRY) RETURNS VOID AS
$$
BEGIN
    LOOP
        UPDATE nodes SET node = newnode 
            WHERE
                ST_Equals(node, newnode) AND 
                node && newnode;
        IF found THEN
            RETURN;
        END IF;

        RAISE NOTICE 'NOT FOUND';

        BEGIN
            INSERT INTO nodes (node) VALUES (newnode);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            --Ignore this and try loop again
        END;
    END LOOP;
END;
$$
LANGUAGE plpgsql;
