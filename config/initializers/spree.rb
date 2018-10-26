# Configure Solidus Preferences
# See http://docs.solidus.io/Spree/AppConfiguration.html for details

Spree.config do |config|
  # config.use_legacy_db_preferences!

  config.for_tenant :pescara_shop do |mt_config|
    mt_config.mails_from = "store@pescara-shop.com"
    mt_config.currency = 'EUR'
  end

  config.for_tenant :latina_shop do |mt_config|
    # Default currency for new sites
    mt_config.currency = "USD"

    # from address for transactional emails
    mt_config.mails_from = "store@latina-shop.com"
  end
end

Spree::Frontend::Config.configure do |config|
  config.for_tenant :pescara_shop do |mt_config|
    mt_config.locale = 'en'
  end

  config.for_tenant :latina_shop do |mt_config|
    # mt_config.use_legacy_db_preferences!

    mt_config.locale = 'it'
  end
end

Spree::Backend::Config.configure do |config|
  config.for_tenant :pescara_shop do |mt_config|
    mt_config.locale = 'en'
  end
end

Spree::Api::Config.configure do |config|
  config.requires_authentication = true
end

Spree.user_class = "Spree::LegacyUser"
