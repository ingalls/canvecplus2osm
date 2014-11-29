CREATE OR REPLACE FUNCTION ref_node(poly GEOMETRY, tags HSTORE) RETURNS VOID AS $$
DECLARE
    nodeArray BIGINT[] := '{}';
    point GEOMETRY;
    rings INTEGER;
BEGIN
    IF GeometryType(poly) = 'LINESTRING' THEN 
        FOR point IN SELECT (ST_DumpPoints(poly)).geom LOOP
            nodeArray := array_append(nodeArray, idx(poly));
        END LOOP;
        INSERT INTO ways(nodes, tags) VALUES (nodeArray, tags);
    ELSIF GeometryType(poly) = 'POLYGON' THEN
        IF ST_NumInteriorRings(poly) = 0 THEN
            RAISE NOTICE 'FUCK';
            FOR point IN SELECT (ST_DumpPoints(poly)).geom LOOP
                nodeArray := array_append(nodeArray, idx(poly));
            END LOOP;
            INSERT INTO ways(nodes, tags) VALUES (nodeArray, tags);
        ELSE
            RAISE NOTICE 'RELATION';
        END IF; 
    ELSE
        RAISE NOTICE 'GEOMETRY TYPE NOT CURRENTLY SUPPORTED';
    END IF;
END;
$$
LANGUAGE plpgsql;
