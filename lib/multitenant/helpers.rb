module NebulabShop
  module Multitenant
    module Helpers
      def current_tenant
        Apartment::Tenant.current
      end

      def within_tenant(tenant, &block)
        Apartment::Tenant.switch(tenant, &block)
      end

      def tenants
        Apartment::Tenant.each(&proc {}).map(&:to_sym)
      end

      def ensure_tenant_existence!(tenant_name)
        raise_apartment_not_found_for(tenant_name) unless tenants.include?(tenant_name.to_sym)
      end

      def raise_apartment_not_found_for(tenant)
        raise Apartment::ApartmentError, "No tenant found for #{tenant}"
      end

      extend self
    end
  end
end
