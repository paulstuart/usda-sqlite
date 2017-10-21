#!/bin/bash

URL=https://www.ars.usda.gov/ARSUserFiles/80400525/Data/SR/SR28/dnload/sr28asc.zip

# handle being called from a different directory
abspath() { cd $(dirname $1); echo $PWD/$(basename $1); }

ZIPFILE=$(basename $URL)
DBFILE=$(abspath ${DBFILE:-usda.db})
DATADIR=$(abspath ${DATADIR:-srcfiles})

[[ -d $DATADIR ]] || mkdir $DATADIR

if [[ ! -f $ZIPFILE ]]; then
    echo "downloading $ZIPFILE"
    curl -skOL $URL
fi

cd $(dirname $0)

echo "preparing database"
cat schema.sql views.sql | sqlite3 $DBFILE 

echo "loading database"
unzip -u -d $DATADIR $ZIPFILE

LOADER=$PWD/load.sql

cd $DATADIR
sqlite3 $DBFILE < $LOADER
