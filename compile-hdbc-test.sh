#!/bin/sh
#ghc -package HDBC-sqlite3-2.3.1.0 hdbc-test.hs
ghc -package HDBC-postgresql-2.2.3.3 -o hdbc-test.bin hdbc-test.hs
