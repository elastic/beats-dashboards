#!/bin/bash

# Usage examples:
# env KIBANA_INDEX='.kibana_env1' ./load.sh
# ./load.sh http://test.com:9200
# ./load.sh http://test.com:9200 test


# The default value of the variable. Initialize your own variables here
ELASTICSEARCH=http://localhost:9200
CURL=curl
KIBANA_INDEX=".kibana"

print_usage() {
  echo "
  
Load the dashboards, visualizations and index patterns into the given
Elasticsearch instance.

Usage:
  $(basename "$0") -url $ELASTICSEARCH -user admin:secret -index $KIBANA_INDEX

Options:
  -h | -help
    Print the help menu.
  -l | -url
    Elasticseacrh URL. By default is $ELASTICSEARCH.
  -u | -user
    Username and password for authenticating to Elasticsearch using Basic
    Authentication. The username and password should be separated by a
    colon (i.e. "admin:secret"). By default no username and password are
    used.
  -i | -index
    Kibana index pattern where to save the dashboards, visualizations,
    index patterns. By default is $KIBANA_INDEX.

" >&2
}

while [ "$1" != "" ]; do
case $1 in
    -l | -url )
        ELASTICSEARCH=$2
        if [ "$ELASTICSEARCH" = "" ]; then
            echo "Error: Missing Elasticsearch URL"
            print_usage
            exit 1
        fi
        ;;

    -u | -user )
        USER=$2
        if [ "$USER" = "" ]; then
            echo "Error: Missing username"
            print_usage
            exit 1
        fi
        CURL="curl --user $USER"
        ;;

    -i | -index )
        KIBANA_INDEX=$2
        if [ "$KIBANA_INDEX" = "" ]; then
            echo "Error: Missing Kibana index pattern"
            print_usage
            exit 1
        fi
        ;;

    -h | -help )
        print_usage
        exit 0
        ;;

     *)
        echo "Error: Unknown option $2"
        print_usage
        exit 1
        ;;

esac
shift 2
done

DIR=dashboards
echo "Loading dashboards to $ELASTICSEARCH in $KIBANA_INDEX"  

# Workaround for: https://github.com/elastic/beats-dashboards/issues/94
$CURL -XPUT "$ELASTICSEARCH/$KIBANA_INDEX"
$CURL -XPUT "$ELASTICSEARCH/$KIBANA_INDEX/_mapping/search" -d'{"search": {"properties": {"hits": {"type": "integer"}, "version": {"type": "integer"}}}}'

for file in $DIR/search/*.json
do
    name=`basename $file .json`
    echo "Loading search $name:"
    $CURL -XPUT $ELASTICSEARCH/$KIBANA_INDEX/search/$name \
        -d @$file || exit 1
    echo
done

for file in $DIR/visualization/*.json
do
    name=`basename $file .json`
    echo "Loading visualization $name:"
    $CURL -XPUT $ELASTICSEARCH/$KIBANA_INDEX/visualization/$name \
        -d @$file || exit 1
    echo
done

for file in $DIR/dashboard/*.json
do
    name=`basename $file .json`
    echo "Loading dashboard $name:"
    $CURL -XPUT $ELASTICSEARCH/$KIBANA_INDEX/dashboard/$name \
        -d @$file || exit 1
    echo
done

for file in $DIR/index-pattern/*.json
do
    name=`awk '$1 == "\"title\":" {gsub(/"/, "", $2); print $2}' $file`
    echo "Loading index pattern $name:"

    $CURL -XPUT $ELASTICSEARCH/$KIBANA_INDEX/index-pattern/$name \
        -d @$file || exit 1
    echo
done


