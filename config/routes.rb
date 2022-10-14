Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get "/index", to: "homes#index"
  root "homes#index"
  get "/new" , to: "homes#new"
  get "/post_a_deal" , to: "homes#post_a_deal"
  get "/about_us" , to: "homes#about_us"
  get "/contact_us" , to: "homes#contact_us"
end
