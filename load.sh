#!/bin/sh

ELASTICSEARCH=http://localhost:9200/

for file in generated/*.json
do
    name=`basename $file .json`
    echo "Loading $name: "
    curl -XPUT $ELASTICSEARCH/kibana-int/dashboard/$name \
        -d @$file || exit 1
    echo
done
