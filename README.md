Packetbeat dashboards
=====================

This repository contains sample Kibana3 dashboards for packet tracing and
application performance monitoring. They are meant to be used together with the
Packetbeat agents and Elasticsearch.

See http://packetbeat.com for details.

Installing
----------
To load the dashboards, edit `load.sh` and set the `ELASTICSEARCH` variable to
contain the URL of your Elasticsearch instance. Then execute the script:

        ./load.sh

That's all there is to it.

Technical details
-----------------
The `dashboards` folder contains the JSON files as exported from Kibana. The
`generated` folder contains the dashboards together with metadata needed for
insertion in Elasticsearch. To re-generate the files, use the `generate.py`
script. If you only want to load the dashboards, you don't need to run that
script.
