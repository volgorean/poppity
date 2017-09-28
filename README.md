# README

config.action_cable.allowed_request_origins = [ 'http://138.68.132.172' ]

sudo restart puma-manager
sudo service nginx restart

sudo -i -u rails

postgres user: rails
postgres pass: fig_bucket

sudo nano /etc/nginx/sites-available/default

RAILS_ENV=production rake db:create db:seed

