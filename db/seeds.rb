# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

MultitenantShop::Stores.each do |tenant, domain|
  Apartment::Tenant.switch(tenant) do
    Rails.root.join("db/seeds/#{tenant}").each_child do |seed_file|
      puts "Loading seed file: #{seed_file}"
      load seed_file
    end
  rescue Errno::ENOENT => e
    puts "there was an error while accessing #{e.message}"
  end
end
