Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  extend DevelopersRoutes
  extend SellersRoutes
  extend BuyersRoutes
  extend PublicRoutes
  extend ChatsRoutes
end
