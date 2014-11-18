echo "DROP TMP DIR"
TMP="$(dirname $0)/tmp"
CACHE="$(dirname $0)/cache"
rm -rf $TMP

echo "
    DROP DATABASE IF EXISTS canvec;
    CREATE DATABASE canvec;
" | psql -U postgres

echo "
    CREATE EXTENSION POSTGIS;
    CREATE EXTENSION hstore;
" | psql -U postgres canvec
