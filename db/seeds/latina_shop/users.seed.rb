email = "lab@latina-shop.com"
password = "sodelatina"
Spree::User.create(
  :login => email,
  :email => email,
  :password => password,
  :password_confirmation => password
)
