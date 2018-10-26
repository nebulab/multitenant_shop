Spree::Sample.load_sample("tax_categories")
Spree::Sample.load_sample("shipping_categories")

tax_category = Spree::TaxCategory.find_by!(name: "Default")
shipping_category = Spree::ShippingCategory.find_by!(name: "Default")

default_attrs = {
  description: "Basic description",
  available_on: Time.current
}

[
  {
    name: "Ruby on Rails Mug",
    shipping_category: shipping_category,
    price: 13.99,
    eur_price: 12
  },
  {
    name: "Ruby on Rails Stein",
    shipping_category: shipping_category,
    price: 16.99,
    eur_price: 14
  }
].each do |product_attrs|
  eur_price = product_attrs.delete(:eur_price)
  Spree::Config[:currency] = "USD"

  product = Spree::Product.create!(default_attrs.merge(product_attrs))
  Spree::Config[:currency] = "EUR"
  product.reload
  product.price = eur_price
  product.shipping_category = shipping_category
  product.save!
end

