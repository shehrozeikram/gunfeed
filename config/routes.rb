Rails.application.routes.draw do


  # Api Section
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      # resource :user, only: %i[show update]
      #
      # devise_scope :user do
      #   resources :users, only: [] do
      #     controller :registrations do
      #       post :create, on: :collection
      #     end
      #   end
      # end


      resource :products do
        get '/index', to: 'products#index'
      end




      # resource :reviews do
      #   post '/create_review', to: 'reviews#create_review'
      #   get '/show_reviews', to: 'reviews#show_reviews'
      # end
      #
      # resource :shops do
      #   get '/show_shop', to: 'shops#show_shop'
      #   get '/fetch_shops', to: 'shops#fetch_shops'
      #   post '/checkout', to: 'shops#checkout'
      #   get '/fetch_related_products', to: 'shops#fetch_related_products'
      #   get '/filter_shops', to: 'shops#filter_shops'
      #
      # end
      #
      #
      # resource :trainers do
      #   get '/show_trainer', to: 'trainers#show_trainer'
      #   get '/fetch_trainers', to: 'trainers#fetch_trainers'
      #   get '/fetch_trainer_booking', to: 'trainers#fetch_trainer_booking'
      #   post '/create_trainer_subscription', to: 'trainers#create_trainer_subscription'
      # end
      #
      #
      # resource :training_programs do
      #
      #   get '/show_training_program', to: 'training_programs#show_training_program'
      #   get '/fetch_training_programs', to: 'training_programs#fetch_training_programs'
      #   get '/show_activity', to: 'training_programs#show_activity'
      #   get '/fetch_activities', to: 'training_programs#fetch_activities'
      #   post '/complete_activity', to: 'training_programs#complete_activity'
      # end
      #
      # resource :payments do
      #   post '/payment', to: 'payments#payment'
      # end
      #
      # resource :resturants do
      #   get '/show_resturant', to: 'resturants#show_resturant'
      #   get '/fetch_resturants', to: 'resturants#fetch_resturants'
      #
      #
      # end
      #
      # resource :resturants_dishes do
      #   get '/show_dish', to: 'resturants_dishes#show_dish'
      #   get '/fetch_dishes', to: 'resturants_dishes#fetch_dishes'
      #   get '/best_seller', to: 'resturants_dishes#best_seller'
      #   get '/filter_dishes', to: 'resturants_dishes#filter_dishes'
      # end
      #
      # resource :business do
      #   get '/show_business', to: 'businesses#show_business'
      #   get '/fetch_business', to: 'businesses#fetch_business'
      #   get '/filter_business', to: 'businesses#filter_business'
      #
      #   # subscription route
      #   post '/create_subscription', to: 'businesses#create_subscription'
      #   get '/fetch_subscriptions' , to: 'businesses#fetch_subscriptions'
      #   get '/fetch_gym_subscriptions' , to: 'businesses#fetch_gym_subscriptions'
      #   get '/fetch_health_club_subscriptions' , to: 'businesses#fetch_health_club_subscriptions'
      #
      # end
      #
      # resource :dish_orders do
      #   post '/create_order', to: 'dish_orders#create_order'
      #   get '/order_again', to: 'dish_orders#order_again'
      #   put '/complete_order', to: 'dish_orders#complete_order'
      #   get '/fetch_orders', to: 'dish_orders#fetch_orders'
      # end


    end
  end




  # MyAccount routes
  get 'my_accounts/views'
  get 'my_accounts/edit'
  get 'my_accounts/my_messages'
  get 'my_accounts/blocked_deal_settings'
  get 'my_accounts/user_deals'
  get 'my_accounts/user_comments'
  get 'my_accounts/user_votes'
  get 'my_accounts/my_reviews'
  get 'my_accounts/my_watchlist'

  resources :reviews


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # search ajax routes

  get "/search_products" , to: "products#search_products"
  get "/fetch_data_from_url" , to: "products#fetch_data_from_url"
  get "/search_compare_guns" , to: "products#search_compare_guns"
  get "/select_gun/:id" , to: "products#select_gun", as: :select_gun
  get 'subscribe_to_newsletter' , to: "news_letter#subscribe_to_newsletter", as: :subscribe_to_newsletter
  get 'subscribe_to_newsletter_mobile' , to: "news_letter#subscribe_to_newsletter_mobile", as: :subscribe_to_newsletter_mobile
  get "/like_product/:id" , to: "products#like_product", as: :like_product
  get "/unlike_product/:id" , to: "products#unlike_product", as: :unlike_product
  get "/map_price/:id" , to: "products#map_price", as: :map_price
  get "/logout_map_price/:id" , to: "products#logout_map_price", as: :logout_map_price
  get "/logout_email" , to: "products#logout_email"

  # main routes
  resources :products
  root to: "products#index"
  get "/search/:id" , to: "products#live_inventory_search", as: :live_inventory_search

  # Main compare gun route
  get ':product_id-vs-:compared_product_id' => 'products#compare_guns', as: :compare_guns

  get "/popular" , to: "products#popular"

  #footer cards routes
  get "/comments-page" , to: "products#recent_comments"

  resources :coupons

  resources :comments

  # watchlist routes
  get "/add_to_watchlist/:id" , to: "watchlist#add_to_watchlist", as: :add_to_watchlist

  resources :customer_reviews
  get 'deals/index'

  resources :news_letter

  # resources :likes
  get "/likes/:product_id" , to: "likes#create"
  get "/unlikes/:product_id" , to: "unlikes#create"

  resources :rebates
  get "/rebates" , to: "products#rebates"

  resources :stores
  get "/xml_feed" , to: "stores#xml_feed"
  get "/fetch_xml_feed_products" , to: "stores#fetch_xml_feed_products"
  get "/stores_comments" , to: "stores#stores_comments"
  get "/cheapest_deals" , to: "stores#cheapest_deals"
  get "/rare_deals" , to: "stores#rare_deals"

  resources :blogs
  get "/fetch_blogs" , to: "blogs#fetch_blogs"

  # Header routes
  get "/search_category_products" , to: "products#search_category_products"
  get "/today" , to: "products#today"
  get "/category/:id" , to: "products#category", as: :category

  # Quicklink routes
  get "/vulcan" , to: "products#vulcan"
  get "/stores" , to: "stores#index"
  get "/blogs" , to: "blogs#index"
  get "/revolvers" , to: "deals#revolvers"
  get "/revolvers/:id" , to: "deals#revolver_show", as: :revolver_show
  get "/rimfire" , to: "deals#rimfire"
  get "/rimfire/:id" , to: "deals#rimfire_show", as: :rimfire_show
  get "/c_and_r" , to: "deals#c_and_r"
  get "/c_and_r/:id" , to: "deals#c_and_r_show", as: :c_and_r_show
  get "/ar_deals" , to: "deals#ar_deals"
  get "/ar_deal/:id" , to: "deals#ar_deal_show", as: :ar_deal_show
  get "/ak_deals" , to: "deals#ak_deals"
  get "/ak_deal/:id" , to: "deals#ak_deal_show", as: :ak_deal_show
  get "/twentytwo_lr_ammo" , to: "deals#twentytwo_lr_ammo"
  get "/twentytwo_lr_ammo/:id" , to: "deals#twentytwo_lr_ammo_show", as: :twentytwo_lr_ammo_show
  get "/nine_mm_ammo" , to: "deals#nine_mm_ammo"
  get "/nine_mm_ammo/:id" , to: "deals#nine_mm_ammo_show", as: :nine_mm_ammo_show
  get "/used_guns" , to: "deals#used_guns"
  get "/used_gun/:id" , to: "deals#used_gun_show", as: :used_gun_show
  get "/top_articles" , to: "deals#top_articles"
  get "/top_article/:id" , to: "deals#top_article_show", as: :top_article_show

  # footer routes
  get "/about_us" , to: "products#about_us"
  get "/contact_us" , to: "products#contact_us"
  get "/FAQ" , to: "products#FAQ"
  # get "/newsletter" , to: "products#newsletter"
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

  # other routes
  post "/notify_me" , to: "products#notify_me"
  post "/report_product" , to: "products#report_product"
  post "/recently_viewed", to: "products#recently_viewed"
end
