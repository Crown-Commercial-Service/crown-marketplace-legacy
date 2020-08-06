#!/usr/bin/env bash

# because the APP_RUN_SIDEKIQ parameter is defined in /Environment/ccs/cmp and not /Environment/ccs/cmpsidekiq,
# we have to check for it being false, so we can run the rails server, otherwise run sidekiq
if [ "$APP_RUN_SIDEKIQ" = 'FALSE' ]; then
  bundle exec rails server
else
  bundle exec sidekiq -C ./config/sidekiq.yml -e production
fi
