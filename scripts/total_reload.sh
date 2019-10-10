#!/bin/bash
set -x


# startup solr
# bundle exec rake sunspot:solr:start
export RAILS_ENV=production
echo "💎 About to reload data for environment $RAILS_ENV"

# all of our rake tasks
dbcreated=.dbcreated
dbseeded=.dbseeded
dbindexed=.dbindexed

if test -f $dbcreated; then
    echo "db already created"
else
    echo "🍒 rake db:create"
    bundle exec rake db:create
    echo "🍒 rake db:reset"
    bundle exec rake db:reset
    echo "🍒 rake db:migrate"
    bundle exec rake db:migrate
    touch $dbcreated
fi


if test -f $dbseeded; then
    echo "db already seeded"
else
    echo "🍒 rake departments"
    bundle exec rake departments
    echo "🍒 solr reindex"
    bundle exec rake sunspot:solr:reindex
    echo "🍒 rake import"
    bundle exec rake import
    echo "🍒 rake course_titles"
    bundle exec rake course_titles
    echo "🍒 rake ic_relations"
    bundle exec rake ic_relations
    echo "🍒 rake grades"
    bundle exec rake grades
    touch $dbseeded
fi


if test -f $dbindexed; then
    echo "db already indexed"
else
    echo "🍒 rake instructor_build_hstore"
    bundle exec rake instructor_build_hstore
    echo "🍒 rake course_build_hstore"
    bundle exec rake course_build_hstore
    echo "🍒 rake department_build_hstore"

    echo "🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒"
    echo "🍒 ONE TIME OPERATIONS 🍒"
    echo "🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒"

    bundle exec rake department_build_hstore
    # remove unnecesarry departments
    bundle exec rake department_correction
    # these rake tasks make slight corrections to the dataset. They should run pretty darn fast
    bundle exec rake course_names
    bundle exec rake course_missing_hstore
    # removes certain names from the project because they don't like it
    bundle exec rake remove
    # reindex solr
    bundle exec rake sunspot:solr:reindex
    touch $dbindexed
fi

echo "jk dawg we ready to launch dev!"
./scripts/dev_launcher.sh
