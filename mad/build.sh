#!/bin/bash

mkdir -p output

files=$(find ./recipe-manual/ -name "*.md" -type f | sort)
for file in $files; do
    echo "Processing $file"
    bb=$(basename $file)
    out_file="output/${bb%.md}.pdf"
    pandoc --template=./templates/recipe_template.tex -o $out_file $file
done

out_files=$(find ./output/ -name "*.pdf" -type f | sort)
if [ -f "recipe_book.pdf" ]; then
    rm recipe_book.pdf
fi

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=recipe_book.pdf $out_files
