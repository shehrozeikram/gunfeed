ActiveAdmin.register Deal do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :price, :store, :amount, :caliber, :category, :brand, :mpn, :upc, :body, :image, :video, :sponsored, :category_id, :website_name, :deal_type, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :price, :store, :amount, :caliber, :category, :brand, :mpn, :upc, :body, :image, :video, :sponsored, :category_id, :website_name, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
