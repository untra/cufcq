#!/bin/bash
bundle exec rake db:reset
bundle exec rake db:migrate
bundle exec rake import
bundle exec rake instructor_populate
bundle exec rake department_populate
