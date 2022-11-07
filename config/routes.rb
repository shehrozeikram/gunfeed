Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { registration: 'registration' }
  # main routes
  resources :products
  root to: "products#index"

  # Header routes
  get "/today" , to: "products#today"

  # footer routes
  get "/stock_guns" , to: "products#stock_guns"
  get "/about_us" , to: "products#about_us"
  get "/contact_us" , to: "products#contact_us"
  get "/FAQ" , to: "products#FAQ"
  get "/newsletter" , to: "products#newsletter"
  get "/moderator" , to: "products#moderator"
  get "/banners" , to: "products#banners"
  get "/giveaways" , to: "products#giveaways"
  get "/banner_ads" , to: "products#banner_ads"
  get "/dealers_advertising" , to: "products#dealers_advertising"
  get "/trusted_retailer_program" , to: "products#trusted_retailer_program"
  get "/dealers_api_access" , to: "products#dealers_api_access"
  get "/terms_service" , to: "products#terms_service"
  get "/privacy_policy" , to: "products#privacy_policy"
  get "/refund_policy" , to: "products#refund_policy"
  get "/how_order_gun_online" , to: "products#how_order_gun_online"
  # get "products/show_page" , to: "products#show_page"
end
