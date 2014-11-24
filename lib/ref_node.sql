CREATE OR REPLACE FUNCTION ref_node(poly GEOMETRY, tags HSTORE) RETURNS VOID AS $$
DECLARE
    nodeArray INTEGER[];
    point GEOMETRY;
BEGIN
    FOR point IN 
        SELECT (ST_DumpPoints(poly)).geom 
    LOOP
        EXECUTE array_append(nodeArray, 1);
    END LOOP;
    INSERT INTO ways(nodes, tags) VALUES (nodeArray, tags);
END;
$$
LANGUAGE plpgsql;
