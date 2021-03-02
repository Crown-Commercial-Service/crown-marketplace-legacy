#!/usr/bin/env bash

# because the APP_RUN_SIDEKIQ parameter is defined in /Environment/ccs/cmp and not /Environment/ccs/cmpsidekiq,
# we have to check for it being false, so we can run the rails server, otherwise run sidekiq
if [ "$APP_RUN_PRECOMPILE_ASSETS" = 'TRUE' ]; then
  bundle exec rake assets:sync
fi

if [ "$APP_RUN_SIDEKIQ" = 'FALSE' ]; then

  bundle exec rake db:migrate:ignore_concurrent

  if [ "$APP_RUN_RAKE_TASKS" = 'TRUE' ]; then
    bundle exec rails command:run
  fi

  bundle exec rails server
else
  bundle exec nginx -g "daemon on;"
  bundle exec sidekiq -C ./config/sidekiq.yml -e production
fi
