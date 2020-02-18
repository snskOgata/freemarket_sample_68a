class Sale < ApplicationRecord
  has_many :photos
  has_many :category_sales, through: :category_sales
  has_one :order
  belongs_to :user
end
