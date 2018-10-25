# MultitenantShop

MultitenantShop is a simple e-commerce based on [Solidus](solidus-gh) with
tutorial-purpose in which I'll show how to migrate a Solidus application from
single to multitenant.

This application aims to serve two different eShops: `www.pescara-shop.com` and
`www.latina-shop.com`. The project relies on the Apartment gem and adopts a
multi-schema implementation offered by [PostgreSQL][postgresql]. Here you can
find more details about the encountered issues and some advice on how to make
Solidus and Apartment work.

### [Solidus and Apartment setup](SETUP.md)
### [Testing with RSpec](spec)

[postgresql]: https://www.postgresql.org/
