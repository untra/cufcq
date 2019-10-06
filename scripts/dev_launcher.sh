#!/bin/bash



#Use this for running cufcq on the dev server 

echo "I SHOULD BE RUNNING ON THE DEV SERVER"
echo "Starting/Reindexing Solr"

export RAILS_ENV=production

rake sunspot:solr:reindex

echo "Solr successful! Starting Rails" 

rails server -b 0.0.0.0 -p 3000

