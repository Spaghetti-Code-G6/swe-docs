#!/bin/sh

cd "$(dirname "$0")"

rm -rf ../docs
mkdir ../docs

TEX_FILES=`find .. -type f -name "*.tex" -mindepth 3 -maxdepth 3`
DIRECTORIES=`find .. -type f -name "*.tex" -mindepth 3 -maxdepth 3 | sed -E 's|/[^/]+$||' |sort |uniq`

if [ -z "$TEX_FILES" ]
then
	echo "Skipping build, no .tex files found!"
else
	echo "File that will be compiled:\n"
	echo "$(basename $TEX_FILES) \n"

	for DIR in $DIRECTORIES
	do
		(cd $DIR && echo "Building .tex files in $DIR ..." | sed 's/\.\.\///' && latexmk -pdf -interaction=nonstopmode -silent > /dev/null)
	done

	PDF_FILES=`find .. -type f -name "*.pdf" -maxdepth 3`

	for PDF in $PDF_FILES
	do
		mv $PDF ../docs
	done

	if [[ $# -gt 0 && $1 == "clean" ]]
	then
		sh ./clean.sh
	fi

	echo "Done!"
fi
