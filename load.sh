#!/bin/sh

if [ -z "$1" ]; then
    ELASTICSEARCH=http://localhost:9200
else
    ELASTICSEARCH=$1
fi

for file in dashboards/search/*.json
do
    name=`basename $file .json`
    echo "Loading search $name:"
    curl -XPUT $ELASTICSEARCH/.kibana/search/$name \
        -d @$file || exit 1
    echo
done

for file in dashboards/visualization/*.json
do
    name=`basename $file .json`
    echo "Loading visualization $name:"
    curl -XPUT $ELASTICSEARCH/.kibana/visualization/$name \
        -d @$file || exit 1
    echo
done

for file in dashboards/dashboard/*.json
do
    name=`basename $file .json`
    echo "Loading dashboard $name:"
    curl -XPUT $ELASTICSEARCH/.kibana/dashboard/$name \
        -d @$file || exit 1
    echo
done
