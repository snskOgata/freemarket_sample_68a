class Photo < ApplicationRecord
  belongs_to :sale, optional: true
  mount_uploader :image, ImageUploader
end
