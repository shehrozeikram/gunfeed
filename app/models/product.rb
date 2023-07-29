class Product < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  belongs_to :store

  has_many :video_reviews
  has_many :reviews
  has_many :comments
  has_many :watchlists
  has_many :blogs
  has_many :rebates
  has_many :recently_vieweds
  has_many :likes, dependent: :destroy
  has_many :unlikes, dependent: :destroy

end
