module NebulabShop
  module Multitenant
    module StoreInstanceDecorator
      include Helpers

      attr_accessor :tenant

      private

      def persist(key, value)
        within_tenant(tenant) { super }
      end

      Spree::Preferences::StoreInstance.prepend self
    end
  end
end
