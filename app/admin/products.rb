ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :product_url, :title, :price, :store, :amount, :category, :caliber, :brand, :mpn, :upc, :body, :user_id, :image, :sponsored, :is_popular
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_url, :title, :price, :store, :amount, :category, :caliber, :brand, :mpn, :upc, :body, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
