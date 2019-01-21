#!/bin/bash
set -e
echo "Downloading and extracting filters ..."
[ -e diamond-classic-filters-20190114.tgz ] || (wget -nv https://github.com/fzqneo/eureka-yfcc100m/releases/download/v19.01-rc/diamond-classic-filters-20190114.tgz; tar xzf diamond-classic-filters-20190114.tgz)
[ -e diamond-image-filters-20190114.tgz ] || (wget -nv https://github.com/fzqneo/eureka-yfcc100m/releases/download/v19.01-rc/diamond-image-filters-20190114.tgz; tar xzf diamond-image-filters-20190114.tgz)
echo "Done"