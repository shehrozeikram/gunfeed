class Blog < ApplicationRecord
  mount_uploader :attachments, ImageUploader
  mount_uploader :video, ImageUploader

  belongs_to :user
  belongs_to :product
end
