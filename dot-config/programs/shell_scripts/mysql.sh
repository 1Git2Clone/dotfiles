#!/bin/sh

INIT_COMMAND="BEGIN TRANSACTION;"

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
	/usr/bin/mysql --init-command="${INIT_COMMAND}"
	exit 0
fi

db_file=$1
shift # Shift the arguments to the left so $@ now contains only the SQL commands

/usr/bin/mysql "$db_file" --init-command="${INIT_COMMAND}" $@
