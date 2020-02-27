class Photo < ApplicationRecord
  belongs_to :sale, optional: true
  mount_uploader :image, ImageUploader
  before_destroy :remove_image

  def remove_image
    image.remove!
  rescue Exception => e
    logger.error(e.message)
  end
end
