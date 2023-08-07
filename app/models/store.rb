class Store < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :products
  has_many :coupons
end
