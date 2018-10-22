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

# Install and setup Apartment

Add Apartment gem to the project dependencies

```ruby
# Gemfile

gem 'apartment', '~> 2.2.0'
```

and then launch the command

```sh
bundle exec rails generate apartment:install
```

This will create the Apartment init file at `config/initializers/apartment.rb`.
Among the whole well-documented settings, you can tell apartment which
_Elevator_ to use (i.e. the criteria for tenant switching). There are a bunch of
built-in elevators in `Apartmen::Elevators` module: Generic, Domain, Subdomain,
FirstSubdomain, Host, HostHash, but you can also define your own custom elevator.
