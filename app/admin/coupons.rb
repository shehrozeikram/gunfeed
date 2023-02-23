ActiveAdmin.register Coupon do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :discount, :coupon_code, :coupon_link, :start_date, :expiration_date, :store_id, :unknown_expiration
  #
  # or
  #
  # permit_params do
  #   permitted = [:discount, :coupon_code, :start_date, :expiration_date, :store_id, :unknown_expiration]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
