Packetbeat dashboards
=====================

This repository contains sample Kibana3 dashboards for packet tracing and
application performance monitoring. They are meant to be used together with the
Packetbeat agents and Elasticsearch.

See http://packetbeat.com for details.


Installation
-------------
To load the dashboards, edit `load.sh` and set the `ELASTICSEARCH` variable to
contain the URL of your Elasticsearch instance. Then execute the script:

        ./load.sh

You should now have the following pages loaded in Kibana:

 - **Packetbeat Statistics**: Contains high-level views like the network topology, the application layer protocols repartition, the response times repartition, and others.
 - **Packetbeat Search**: This page enables you to do full text searches over the indexed network messages.
 - **MySQL Performance**: This page demonstrates more advanced statistics like the top N slow MySQL queries, most frequent MySQL queries, the database throughput or database responsetime. To investigate a failure in your network, you can drill down to see all MySQL transactions in real-time.
 - **PgSQL Performance**: Similar with MySQL Performance dashboard, but for the Postgresql transactions.

You can switch between the dashboards by using the *Load* menu.

![Load menu](http://packetbeat.com/static/screenshots/load_menu.png)

or the *dashboard dropdown*.

![dashboard dropdown](http://packetbeat.com/static/screenshots/dashboard_dropdown.png)

Technical details
-----------------
The `dashboards` folder contains the JSON files as exported from Kibana. The
`generated` folder contains the dashboards together with metadata needed for
insertion in Elasticsearch. To re-generate the files, use the `generate.py`
script. If you only want to load the dashboards, you don't need to run that
script.

Screenshots
-----------

![Packetbeat Statistics](http://packetbeat.com/static/screenshots/dashboard_statistics.png)

![Packetbeat Search](http://packetbeat.com/static/screenshots/dashboard_search.png)

You can find more screenshots in the `screenshots` folder.

