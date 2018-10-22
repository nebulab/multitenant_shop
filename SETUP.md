# Install and setup Solidus gem

Init new Rails application with PostgreSQL.

```sh
$ rails new nebulab_shop --database=postgresql
```
    
Add 'solidus' and 'solidus_auth_devise' to Gemfile

```ruby
gem 'solidus', '~> 2.6'
gem 'solidus_auth_devise', '~> 2.1.0'
```

then launch:

```sh
$ bundle exec rails g spree:install
$ bundle exec rails g solidus:auth:install
$ bundle exec rake railties:install:migrations
$ bundle exec rake spree_sample:load
```
