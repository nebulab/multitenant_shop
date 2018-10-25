require 'rails_helper'

RSpec.feature Spree::Preferences, type: :feature do
  describe "when visiting test_app" do
    let(:mails_from) { "store@pescara-shop.com" }
    let(:locale) { :en }

    before do
      Capybara.app_host = "http://pescara-shop.com"
      visit spree.products_path
    end

    it "sets the correct tenant" do
      expect(Apartment::Tenant.current).to eq("pescara_shop")
    end

    it "sets the correct locale" do
      expect(I18n.locale).to eq(locale)
      expect(page).to have_content(/cart/i)
    end

    it 'fetch Solidus preferences from the correct tenant' do
      expect(page).to have_css("li#mails-from.testing", text: "Contact us at #{mails_from}")
    end
  end
end
