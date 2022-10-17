Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get "/index", to: "homes#index"
  root "homes#index"
  get "/today" , to: "homes#today"
  get "/stock_guns" , to: "homes#stock_guns"
  get "/new" , to: "homes#new"
  get "/post_a_deal" , to: "homes#post_a_deal"
  get "/about_us" , to: "homes#about_us"
  get "/contact_us" , to: "homes#contact_us"
  get "/FAQ" , to: "homes#FAQ"
  get "/newsletter" , to: "homes#newsletter"
  get "/moderator" , to: "homes#moderator"
  get "/banners" , to: "homes#banners"
  get "giveaways" , to: "homes#giveaways"
  get "/banner_ads" , to: "homes#banner_ads"
  get "/dealers_advertising" , to: "homes#dealers_advertising"
  get "/trusted_retailer_program" , to: "homes#trusted_retailer_program"
  get "/dealers_api_access" , to: "homes#dealers_api_access"
  get "/terms_service" , to: "homes#terms_service"
  get "/privacy_policy" , to: "homes#privacy_policy"
  get "/refund_policy" , to: "homes#refund_policy"
  get "/how_order_gun_online" , to: "homes#how_order_gun_online"
  get "/show_page" , to: "homes#show_page"




end
