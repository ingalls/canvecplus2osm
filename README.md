canvecplus2osm
==============

Convert Canvec to OSM

## Setup

Run `./setup.sh` to create the necessary database & corresponding tables

## Import 

Run `./import.sh` to download Canvec data area by area and load into the database for conversion to osm

## PostGIS ==> Canvec

This script can easily be modified to convert any PostGIS database to the OSM format.

### Tables

The `lib/osm-create.sh` only requires three tables to convert to osm. These tables are:

- `osm_pt` - Geometry of type `GEOMETRY(POINT, 4326)`
- `osm_ln` - Geometry of type `GEOMETRY(LINESTRING, 4326)`
- `osm_pg` - Geometry of type `GEOMETRY(POLYGON, 4326)` or `GEOMETRY(MULTIPOLYGON, 4326)`

The end result is a series of 3 tables:

| Table Name  | Headers                                                         | Description |
| :---------: | --------------------------------------------------------------- | ----------- |
| `nodes`     | `id BIGINT`, `geom GEOMETRY(POINT, 4326)`, `tags HSTORE`        | This table contains distinct nodes from all geometry types as well as tags on individual nodes and each node's corresponding id. |
| `ways`      | `id BIGINT`, `nodes BIGINT[]`, `tags HSTORE`                    | This table contains distinct ways. Each row has the way's temporray id, as well as an array of node ids that make up the way and tags for that specific way. | 
| `relations` | `id BIGINT`, `tags HSTORE`, @TODO                               | This table contains distinct multipolygon type relations. Each row has the id, the inner and outer ways, and the relation's corresponding tags. |
