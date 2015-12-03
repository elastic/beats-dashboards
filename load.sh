#!/bin/bash

if [ -z "$1" ]; then
    ELASTICSEARCH=http://localhost:9200
else
    ELASTICSEARCH=$1
fi

if [ -z "$2" ]; then
    KIBANAINDEX=".kibana"
else
    KIBANAINDEX=$2
fi

if [ -z "$3" ]; then
    CURL=curl
else
    CURL="curl --user $3"
fi

echo $CURL
DIR=dashboards

for file in $DIR/search/*.json
do
    name=`basename $file .json`
    echo "Loading search $name:"
    $CURL -XPUT $ELASTICSEARCH/$KIBANAINDEX/search/$name \
        -d @$file || exit 1
    echo
done

for file in $DIR/visualization/*.json
do
    name=`basename $file .json`
    echo "Loading visualization $name:"
    $CURL -XPUT $ELASTICSEARCH/$KIBANAINDEX/visualization/$name \
        -d @$file || exit 1
    echo
done

for file in $DIR/dashboard/*.json
do
    name=`basename $file .json`
    echo "Loading dashboard $name:"
    $CURL -XPUT $ELASTICSEARCH/$KIBANAINDEX/dashboard/$name \
        -d @$file || exit 1
    echo
done

for file in $DIR/index-pattern/*.json
do
    name=`basename $file .json`
    printf -v escape "%q" $name
    echo "Loading index pattern $escape:"

    $CURL -XPUT $ELASTICSEARCH/$KIBANAINDEX/index-pattern/$escape \
        -d @$file || exit 1
    echo
done


