#!/bin/bash
set -x

#kill solr process
# pkill -f solr

#remove old data
# rm -rf solr/data
# rm -rf solr/default
# rm -rf solr/development
# rm -rf solr/pids
# rm -rf solr/test

# while getopts 'pdt' flag; do
#   case "${flag}" in
#     d) export RAILS_ENV=development ;;
#     p) export RAILS_ENV=production ;;
#     t) export RAILS_ENV=test ;;
#     *) error "Unexpected option ${flag}" ;;
#   esac
# done

#startup solr
# bundle exec rake sunspot:solr:start
export RAILS_ENV=production
echo "💎 About to reload data for environment $RAILS_ENV"

#all of our rake tasks

# echo "🍒 rake rake db:create"
# bundle exec rake db:create
# echo "🍒 rake rake db:reset"
# bundle exec rake db:reset
# echo "🍒 rake rake db:migrate"
# bundle exec rake db:migrate
echo "🍒 rake rake departments"
bundle exec rake departments
echo "solr reindex"
bundle exec rake sunspot:solr:reindex
echo "🍒 rake rake import"
bundle exec rake import
echo "🍒 rake rake course_titles"
bundle exec rake course_titles
echo "🍒 rake rake ic_relations"
bundle exec rake ic_relations
echo "🍒 rake rake grades"
bundle exec rake grades
# build the hstore for departments
echo "🍒 rake instructor_build_hstore"
bundle exec rake instructor_build_hstore
echo "🍒 rake course_build_hstore"
bundle exec rake course_build_hstore
echo "🍒 rake department_build_hstore"
bundle exec rake department_build_hstore

# remove unnecesarry departments
bundle exec rake department_correction

# these rake tasks make slight corrections to the dataset. They should run pretty darn fast
bundle exec rake course_names
bundle exec rake course_missing_hstore

#removes certain names from the project because they don't like it
bundle exec rake remove

#reindex solr
bundle exec rake sunspot:solr:reindex
