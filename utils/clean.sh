#!/bin/sh

FILE_PATHS="./interni ./esterni"

remove_files() {
	find $1 -not -path "*/img*" -type f ! \( $FILES \) -delete
	find $1 -type d -empty -mindepth 1 -delete
}

set_files() {
	if [ $1 = "all" ];	then
	echo "Removing all files generated from the build..."
		FILES="-name "*.tex""
	elif [ $1 = "tmp" ]; then
		echo "Removing temporary files generated from the build..."
		FILES="-name "*.tex" -o -name "*.pdf""
	fi
}

set_files $1

for path in $FILE_PATHS
do
	remove_files $path
done
