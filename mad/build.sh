#!/bin/bash

mkdir -p output output_shopping

files=$(find ./recipe-manual/ -name "*.md" -type f | sort)
for file in $files; do
    echo "processing $file"
    bb=$(basename $file)
    out_file="output/${bb%.md}.pdf"
    pandoc --template=./templates/recipe_template.tex -o $out_file $file
done

out_files=$(find ./output/ -name "*.pdf" -type f | sort)
if [ -f "recipe_book.pdf" ]; then
    rm recipe_book.pdf
fi

echo "generating recipe_book.pdf from ${out_files}"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=recipe_book.pdf $out_files


for file in $files; do
    echo "processing $file"
    bb=$(basename $file)
    out_file="output_shopping/${bb%.md}.pdf"
    pandoc --template=./templates/shopping_template.tex -o $out_file $file
done

out_files=$(find ./output_shopping/ -name "*.pdf" -type f | sort)
if [ -f "shopping_book.pdf" ]; then
    rm shopping_book.pdf
fi

echo "generating shopping_book.pdf from ${out_files}"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=shopping_book.pdf $out_files

