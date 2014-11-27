CREATE OR REPLACE FUNCTION ref_node(poly GEOMETRY, tags HSTORE) RETURNS VOID AS $$
DECLARE
    nodeArray BIGINT[] := '{}';
    point GEOMETRY;
    id BIGINT;
BEGIN
    IF GeometryType(poly) = 'LINESTRING' THEN 
        FOR point IN 
            SELECT (ST_DumpPoints(poly)).geom 
        LOOP
            id := ('x'||substr(md5(point::TEXT), 0, 9))::bit(32)::BIGINT; 
            nodeArray := array_append(nodeArray, id);
        END LOOP;
        INSERT INTO ways(nodes, tags) VALUES (nodeArray, tags);
    ELSIF GeometryType(poly) = 'MULTIPOLYGON' THEN
        RAISE NOTICE count(ST_Dump(poly));
        IF count(ST_Dump(poly)) = 1 THEN
            RAISE NOTICE 'POLY';
        ELSE
            RAISE NOTICE 'MULTIPOLY';
        END IF; 
    ELSE
        RAISE NOTICE 'GEOMETRY TYPE NOT CURRENTLY SUPPORTED';
    END IF;
END;
$$
LANGUAGE plpgsql;
