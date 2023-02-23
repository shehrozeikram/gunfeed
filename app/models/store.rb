class Store < ApplicationRecord
  has_many :products
  has_many :coupons
end
