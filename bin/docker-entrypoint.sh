#!/usr/bin/env bash

# because the APP_RUN_SIDEKIQ parameter is defined in /Environment/ccs/cmp and not /Environment/ccs/cmpsidekiq,
# we have to check for it being false, so we can run the rails server, otherwise run sidekiq
if [ "$APP_RUN_PRECOMPILE_ASSETS" = 'TRUE' ]; then
  bundle exec rake assets:sync
fi

if [ "$APP_RUN_SIDEKIQ" = 'FALSE' ]; then
  if [ "$APP_RUN_STATIC_TASK" = 'TRUE' ]; then
    bundle exec rails db:static
  fi

  bundle exec rails server
else
  bundle exec sidekiq -C ./config/sidekiq.yml -e production
fi
