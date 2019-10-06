#!/usr/bin/env bash
set -e

echo "launching the cufcq production entry point"

echo "PRODUCTION MODE"

rake assets:precompile

./solr_start.sh -p

echo "Starting server."
sudo passenger start -a 0.0.0.0 -p 80 -e production -d
echo "Server daemon started. "
