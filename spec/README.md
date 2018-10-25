# Testing with RSpec

Since Solidus uses [RSpec][rspec-homepage], I'have focused my analysis on how this testing suite works with Apartment gem. Let's begin taking a look at this [Apartment wiki page][apartment-testing]. Here we can find most of instructions and best practices we need:

> The number one thing that has helped us in testing is to create a single tenant before the whole test suite runs and switch to that tenant for the run of your tests.

In fact, testing with feature (JS) specs it's quite a mess.. If I'm not wrong, the reason is the same why we could not use __transactional tests_ with Capybara:

> Transactional fixtures do not work with Selenium tests, because Capybara uses a separate server thread, which the transactions would be hidden from. We hence use DatabaseCleaner to truncate our test database.

See [here][apartment-capybara-issue444] for more details.

> Capybara does it's stuff in a separate thread to the main test thread. due to connection sharing in rails 5.1, both threads use the same database connection. apartment instantiates a different adapter object per thread, and the capybara adapter doesn't receive the switch! issued during test bootstrapping, so as far as it's concerned the "current" tenant is still the default_tenant 'public' (despite the main test thread, and main test apartment adapter, changing the "schema_search_path" for the shared connection).

The combination of the mandatory use of [DatabaseCleaner][dbcleaner-gh] and the need of testing against a single test-tenant, produce a quite standard configuration like this:

```ruby
# spec/rails_helper.rb

RSpec.configure do |config|

  config.use_transactional_fixtures = true

  config.before(:suite) do
    # clean all tables to start
    databasecleaner.clean_with :truncation
    # use transactions for tests
    databasecleaner.strategy = :transaction
    # truncating doesn't drop schemas, ensure we're clean here, app *may not* exist
    apartment::tenant.drop('test_app') rescue nil
    # create the default tenant for our tests
    apartment::tenant.create('test_app')
  end

  config.before(:each) do
    # Start transaction for this test
    DatabaseCleaner.start
    # Switch into the default tenant
    Apartment::Tenant.switch! 'test_app'
  end

  config.after(:each) do
    # Reset tentant back to `public`
    Apartment::Tenant.reset
    # Rollback transaction
    DatabaseCleaner.clean
  end
end
```

Here a little sum up on how to set host in request spec

```ruby
# Integration Specs (inheriting from ActionDispatch::IntegrationTest):
host! "my.awesome.host"

# Controller Specs (inheriting from ActionController::TestCase)
@request.host = 'my.awesome.host'

# View Specs (inheriting from ActionView::TestCase)
@request.host = 'my.awesome.host'

# ...or through RSpec:
controller.request.host = "my.awesome.host"
```

[apartment-testing]: https://github.com/influitive/apartment/wiki/Testing-Your-Application
[apartment-capybara-issue444]: https://github.com/influitive/apartment/issues/444
[dbcleaner-gh]: https://github.com/DatabaseCleaner/database_cleaner
[rspec-homepage]: http://rspec.info/
