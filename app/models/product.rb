class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category

  has_many :reviews
  has_many :comments
end
