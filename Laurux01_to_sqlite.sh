#!/bin/sh

# Converts Laurux01 SQL DB to a mysqldump
mysqldump  --default-character-set=utf8mb4 --skip-extended-insert --compact "$@" Laurux01 | ./mysql2sqlite - | sqlite3 Laurux01_converted.sqlite
