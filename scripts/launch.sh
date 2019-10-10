#!/usr/bin/env bash
set -e

echo "launching the cufcq production entry point"

echo "PRODUCTION MODE"

rake assets:precompile

# ./scripts/solr_start.sh -p
echo "FFFFFF"
echo "🍉 PREPARING TO RELOAD IT ALL"
sleep 10

./scripts/total_reload.sh

# echo "Starting server."
# rails server -b 0.0.0.0 -p 3000
# echo "Server daemon started. "
