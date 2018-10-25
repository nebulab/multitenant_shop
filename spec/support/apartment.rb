RSpec.configure do |config|
  config.before(:suite) do
    # Use transactions for tests
    DatabaseCleaner.strategy = :transaction
    Apartment::Tenant.drop('pescara_shop') rescue nil
    # Create the default tenant for our tests
    Apartment::Tenant.create('pescara_shop')
  end

  config.before(:each) do
    # Start transaction for this test
    DatabaseCleaner.start
    Apartment::Tenant.drop('pescara_shop') rescue nil
    # Create the default tenant for our tests
    Apartment::Tenant.create('pescara_shop')
  end

  config.before(:each, type: :feature) do
    Apartment::Tenant.switch!('pescara_shop')
  end

  config.after(:each) do
    # Reset tenant back to `public`
    Apartment::Tenant.reset rescue nil
    # Rollback transaction
    DatabaseCleaner.clean
  end

  config.before(:example, type: :integration) do |example|
    host! extract_host_from_example(example)
  end

  config.before(:example, type: :request) do |example|
    host! extract_host_from_example(example)
  end

  config.before(:example, type: :controller) do |example|
    controller.request.host = extract_host_from_example(example)
  end

  config.before(:example, type: :view) do |example|
    @request.host = extract_host_from_example(example)
  end

  config.before(:example, type: :feature) do |example|
    domain = extract_host_from_example(example)
    Capybara.app_host = "http://#{domain}"
  end

  def extract_host_from_example(example)
    tenant = example.metadata[:tenant] || "pescara_shop"
    NebulabShop::Stores[tenant.to_sym]
  end
end
