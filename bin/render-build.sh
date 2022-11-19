#!/usr/bin/env bash
# exit on error
set -o errexit
# Set database.yml
cp -v config/database.example.yml config/database.yml

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate