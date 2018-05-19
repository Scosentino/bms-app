web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -c 7 -t 20 -C config/sidekiq.yml