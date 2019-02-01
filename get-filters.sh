#!/bin/bash
set -e

declare -a FILTER_URLS=(
    "https://github.com/fzqneo/eureka-yfcc100m/releases/download/v19.02-rc/diamond-core-filters-20190201.tgz"
    "https://github.com/fzqneo/eureka-yfcc100m/releases/download/v19.02-rc/diamond-image-filters-20190201.tgz"
)

echo "Downloading and extracting filters ..."

for URL in ${FILTER_URLS[@]}; do
    FILE=$(basename $URL)
    [ -e $FILE ] || (wget -nv $URL; tar xzf $FILE)
done;

echo "Done"