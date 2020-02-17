class Photo < ApplicationRecord
  belongs_to: :sale
  mount_uploader :image, ImageUploader
end
