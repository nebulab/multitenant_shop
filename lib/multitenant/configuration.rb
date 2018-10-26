module NebulabShop
  module Multitenant
    module ConfigurationDecorator
      module HandleMultiConfiguration; end

      include Helpers

      attr_accessor :tenant

      def for_tenant(tenant = :public)
        # We include this module to keep track of "master" Configuration, the only
        # instance handling all other instances stored in tenants_preferences
        # (this is needed to avoid #preferences throw a recursive loop)
        set_master!
        tenants_preferences_for(tenant).tap do |prefs|
          yield prefs if block_given?
        end
      end

      def tenants_preferences
        @tenants_preferences ||= {}
      end

      def tenants_preferences_for(tenant)
        tenants_preferences[tenant.to_sym] ||= new_app_configuration_for tenant
      end

      def preferences
        # Check if we are a "master" Configuration
        return super unless is_master?
        tenants_preferences_for(current_tenant).preferences
      end

      def use_legacy_db_preferences!
        super.tap { |pref_store| pref_store.store.tenant = tenant }
      end

      def use_legacy_db_preferences!
        super.tap { |pref_store| pref_store.store.tenant = tenant }
      end

      def new_app_configuration_for(tenant)
        self.class.new.tap do |new_app_conf|
          new_app_conf.tenant = tenant
          if preference_store.is_a?(Spree::Preferences::ScopedStore)
            new_app_conf.use_legacy_db_preferences!
          end
        end
      end

      def is_master?
        is_a? HandleMultiConfiguration
      end

      def set_master!
        extend HandleMultiConfiguration
      end

      Spree::Preferences::Configuration.prepend self
    end
  end
end
