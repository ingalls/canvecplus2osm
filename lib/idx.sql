CREATE OR REPLACE FUNCTION idx(geom GEOMETRY) RETURNS BIGINT AS $$
DECLARE
    id BIGINT;
BEGIN
    id := ('x'||substr(md5(geom::TEXT), 0, 9))::bit(32)::BIGINT;
    RETURN id;
END;
$$
LANGUAGE plpgsql;
