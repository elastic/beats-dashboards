Packetbeat dashboards
=====================

This repository contains sample Kibana4 dashboards for application and network
tracing and performance monitoring. They are meant to be used together with the
Packetbeat agents and Elasticsearch.

See http://packetbeat.com for details.


Installation
-------------

To load the dashboards, execute the script pointing to the Elasticsearch HTTP
URL:

        ./load.sh http://localhost:9200

You should now have the following pages loaded in Kibana:

 - **Packetbeat Statistics**: Contains high-level views like the network topology, the application layer protocols repartition, the response times repartition, and others.
 - **Packetbeat Search**: This page enables you to do full text searches over the indexed network messages.
 - **MySQL Performance**: This page demonstrates more advanced statistics like the top N slow MySQL queries, most frequent MySQL queries, the database throughput or database responsetime. To investigate a failure in your network, you can drill down to see all MySQL transactions in real-time.
 - **PgSQL Performance**: Similar with MySQL Performance dashboard, but for the Postgresql transactions.


Technical details
-----------------
The `dashboards` folder contains the JSON files as exported from Kibana, by
using the simple python tool from the `save` directory. The loader is a simple
shell script so that you don't need python installed when loading the
dashboards.

Screenshots
-----------

TODO
