# usda-sqlite
Scripts to load USDA nutrition data into a sqlite database.

Data is sourced from the [USDA website](http://www.ars.usda.gov/Services/docs.htm?docid=8964)

To load, unpack the data and copy the sql script into the resulting directory.

    sqlite3 usda.db < load.sql

Tables names reflect the source data files.
