class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  belongs_to :store

  has_many :reviews
  has_many :comments
  has_many :watchlists
  has_many :blogs
  has_many :rebates

end
