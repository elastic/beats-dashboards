Beats dashboards
================

This repository contains sample Kibana4 dashboards for visualizing the data
gathered by the Elastic [Beats](https://www.elastic.co/products/beats).

Installation
-------------

To load the dashboards, execute the script pointing to the Elasticsearch HTTP
URL:

        # Unix
        ./load.sh -url "http://localhost:9200"

        # Windows
        .\load.ps1 -url "http://localhost:9200"

If you want to use HTTP authentication for Elasticsearch, you can specify the
credentials as a second parameter:

        # Unix
        ./load.sh -url "http://localhost:9200" -user "admin:secret"

        # Windows
        .\load.ps1 -url "http://localhost:9200" -user "admin:secret"

Technical details
-----------------
The `dashboards` folder contains the JSON files as exported from Kibana, by
using the simple python tool from the `save` directory. The loader is a simple
shell script so that you don't need python installed when loading the
dashboards.


Create a new dashboard
----------------------

If you added support for a new protocol in Packetbeat or a module in
Metricbeat, it would be nice to create a dedicated Kibana dashboard to 
visualize your data.
The Kibana dashboards are saved in a special index in Elasticsearch. By default
it's `.kibana`, but it can be configured to anything else.

The first step in creating your own Kibana dashboard is to get a fresh
installation of the Kibana dashboards/visualizations/searches/index patterns,
that you can use as a starting point for your own dashboard. You can use the 
`load.sh` script on Unix and `load.ps1` on Windows for loading the sample 
dashboards/visualizations/searches/index patterns in Kibana. The usage of this
script is described above.

Note: Make sure you are using the latest Kibana version to create and download
the dashboards.

Then, you can create the dashboard together with the necessary
visualizations and searches in Kibana. After the dashboard is ready, you can download 
all the dashboards using the `save/kibana_dump.py` script. 

Before executing the save/kibana_dump.py script, make sure you have python and virtualenv
installed:

        # Prepare the environment
        virtualenv env
        . env/bin/activate
        pip install -r requirements.txt

        # go to save directory
        cd save

        # Download all Kibana dashboards to your host
        python kibana_dump.py --url 'http://localhost:9200' --dir output

where `url` points to the Elasticsearch URL, and `dir` is the directory where
you want to save the Kibana dashboards.

Finally, copy the related dashboards, visualizations, searches and
eventually index patterns to the `dashboards` directory, and send us a pull request.



Screenshots
-----------

  ![Packetbeat Statistics](/screenshots/Packetbeat-statistics.png)
  ![MySql performance](/screenshots/MySql-performance.png)
  ![Thrift performance](/screenshots/Thrift-performance.png)
  ![Windows Event Log Statistics](/screenshots/winlogbeat-dashboard.png)
  ![NFS traffic Statistics](/screenshots/NFS-dashboard.png)
