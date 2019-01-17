#!/bin/sh
set -e

sh $(dirname $0)/get-filters.sh

echo "Searching for hyperfind.jar in ${HYPERFIND_PATH:=$(realpath `dirname $0`/..)} ..."
[ -e $HYPERFIND_PATH/hyperfind.jar ] || (echo "Failed! Have you downloaded and compiled HyperFind?" >&2; exit 1)
echo "OK."

BUNDLES="$(dirname $0)/diamond/codecs:$(dirname $0)/diamond/predicates"
FILTERS="$(dirname $0)/diamond/filters"

java -jar $HYPERFIND_PATH/hyperfind.jar $BUNDLES $FILTERS