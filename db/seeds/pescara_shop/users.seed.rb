email = "panic-room@pescara-shop.com"
password = "sexdrugsrocknroll"
Spree::User.create(
  :login => email,
  :email => email,
  :password => password,
  :password_confirmation => password
)
