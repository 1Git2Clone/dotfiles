#!/bin/bash

for filename in *; do
	if [[ -f "$filename" ]]; then
		new_filename="${filename// /_}" # replace spaces with underscores
		mv "$filename" "$new_filename"
	fi
done
