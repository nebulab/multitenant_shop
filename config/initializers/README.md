# Setup Stores (i.e. Tenants)

In our example we use the `HostHash` elevator which establish an hard-coded association from a
domain name to a tenant, so if we get a request to 'http://pescara-shop.com' the
apartment gem will switch to `pescara_shop` tenant.

```ruby
NebulabShop::Stores = {
  pescara_shop: 'pescara-shop.com',
  latina_shop: 'latina-shop.com'
}
```

Now we have to create our tenants

```ruby
$ bin/rails console
irb> MultitenantShop::Stores.keys.each { |store| Apartment::Tenant.create(store) }
```

this will also seed your stores, if you ave the config `config.seed_after_create = true`.
Otherwise run

```ruby
irb> MultitenantShop::Stores.keys.each do |store|
  Apartment::Tenant.switch(store) { Apartment::Tenant.seed }
end
```

Remember to use 

```ruby
irb> ActiveRecord::Base.logger.level = Logger::INFO
```

to avoid output floods and improve performances.
You can verify that new schemas were actually created in your database as follow

```sh
$ psql nebulab_shop_development -c "\dn"

    List of schemas
     Name     |  Owner
--------------|---------
 latina_shop  | seller
 pescara_shop | seller
 public       | seller
(3 rows)
```

