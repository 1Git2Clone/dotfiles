#!/bin/sh

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
	echo "Usage: sqlite3.sh database_file"
	exit 1
fi

db_file=$1
shift # Shift the arguments to the left so $@ now contains only the SQL commands

sqlite3 "$db_file" <<EOF
BEGIN TRANSACTION; -- This is the whole reason of this script
EOF
