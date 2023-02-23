class AddCouponLinkToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :coupon_link, :string
  end
end
