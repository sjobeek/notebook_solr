#!/bin/bash

#Launch solr, overlaying current ./solr directory

sudo docker run -d -p 8983:8983 \
     -v $(pwd)/solr:/opt/solr-4.10.3/example/solr nbsolr

