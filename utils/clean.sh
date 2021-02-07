#!/bin/sh

# paths relative to this file
FILE_PATHS="../interni ../esterni ../docs"

remove_files() {
	find $1 -not -path "*/img*" -type f ! \( $FILES \) -delete 2>/dev/null
	find .. -type d -empty -delete 2>/dev/null

}

set_files() {
	if [ $# -eq 0 ]; then
		echo "Removing temporary files generated from the build..."
		FILES="-name "*.tex" -o -name "*.pdf""
	elif [ $1 == "all" ]; then
	echo "Removing all files generated from the build..."
		FILES="-name "*.tex""
	fi
}

cd "$(dirname "$0")"
set_files $1

for path in $FILE_PATHS
do
	remove_files $path
done

echo "Done!"
