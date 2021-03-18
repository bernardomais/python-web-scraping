#!/usr/bin/env bash

S3URL=s3://shoppingbrasil-app-int-ai
FOLDER_INFO=digitalizacao
INFO_DIR=response

echo -e "scrape..."
python3 ./main.py
echo -e "no more scrape!"

echo -e "compress the result."
for file in $INFO_DIR/*; do
    zip ${file%.*}.zip $file && rm -rf $file
done
echo -e "finish compress the result."

aws s3 cp $INFO_DIR $S3URL/$FOLDER_INFO --exclude "*" --include "*.zip" --recursive

if [ $? -eq 0 ]; then
    echo -e "Done!"
    exit 0
fi

echo -e "Error!"
exit 1