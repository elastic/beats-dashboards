#!/bin/sh

ES_URL=http://localhost:9200/

for file in generated/*.json
do
    name=`basename $file .json`
    echo "Loading $name: "
    curl -XPUT $ES_URL/kibana-int/dashboard/$name \
        -d @$file || exit 1
    echo
done
