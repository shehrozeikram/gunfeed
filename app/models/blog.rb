class Blog < ApplicationRecord
  mount_uploader :attachments, ImageUploader
  mount_uploader :video, ImageUploader
end
