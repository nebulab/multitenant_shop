# Configure Solidus Preferences
# See http://docs.solidus.io/Spree/AppConfiguration.html for details

Apartment::Tenant.switch(:latina_shop) do
  Spree.config do |config|
    # config.use_legacy_db_preferences!

    # Default currency for new sites
    config.currency = "EUR"

    # from address for transactional emails
    config.mails_from = 'store@latina-shop.com'
  end

  Spree::Frontend::Config.configure do |config|
    config.locale = 'it'
  end

  Spree::Backend::Config.configure do |config|
    config.locale = 'it'
  end
end

Apartment::Tenant.switch(:pescara_shop) do
  Spree.config do |config|
    # config.use_legacy_db_preferences!

    # Default currency for new sites
    config.currency = "USD"

    # from address for transactional emails
    config.mails_from = 'store@pescara-shop.com'
  end

  Spree::Frontend::Config.configure do |config|
    config.locale = 'en'
  end

  Spree::Backend::Config.configure do |config|
    config.locale = 'en'
  end
end

Spree::Api::Config.configure do |config|
  config.requires_authentication = true
end

