# Seeding

I reccomend using plain-old Rails seed mechanism instead of external gems. One
of the most famous is [Seedbank][seedbank-gh], but seems not working within
apartment (and lacks support for Rails 5). You can seeds a tenant via Rake tasks
(`bin/rake apartment:seed`) or directly via console (`Apartment::Tenant.seed`),
but this basically launch seed task to populate all tenants with same data. Here's
a more fine-grained and organized approach let's you to seeds each store with
it's own data.

```ruby
# config/db/seeds.rb

NebulabShop::Stores.each do |tenant, domain|
  Apartment::Tenant.switch(tenant) do
    Rails.root.join("db/seeds/#{tenant}").each_child do |seed_file|
      puts "Loading seed file: #{seed_file}"
      load seed_file
    end
  rescue Errno::ENOENT => e
    puts "there was an error while accessing #{e.message}"
  end
end
```

Unfortunately seeding database in this way will break if you have enabled the
the Apartment option that automatically launch seeds after tenant creation, so
remember to set it to `false`.

```ruby
# config/initializers/apartment.rb

Apartment.configure do |config|
  config.seed_after_create = false
end
```

[seedbank-gh]: https://github.com/james2m/seedbank
