#!/usr/bin/env bash
set -e

echo "launching the cufcq production entry point"

echo "PRODUCTION MODE"

rake assets:precompile

echo "skipping legacy solr_start (but will we index?)"
# ./scripts/solr_start.sh -p

echo "🍉 PREPARING TO RELOAD IT ALL"
sleep 10

./scripts/total_reload.sh

echo "Starting server."
rails server -b localhost -p 3000 -e production -d
echo "Server daemon started. "
