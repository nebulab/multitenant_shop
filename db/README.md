# About migrations

When migrating to multi-schema, you have to execute some operations in the correct
order.

```ruby
$ bin/rails c
irb> ActiveRecord::Base.logger.level = 1
irb> Apartment.tenant_names.keys.each { |store| Apartment::Tenant.create(store) }
^D
$ bin/rake db:migrate
```
