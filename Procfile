web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -c 5 -t 20 -C config/sidekiq.yml