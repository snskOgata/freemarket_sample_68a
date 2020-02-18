class Sale < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :detail, :condition_id, :delivery_payer_id, 
    :prefecture_id, :prep_days_id, :price, :status_id, presence: true
  validates :name, length: { maximum: 40 }

  has_many :category_sales
  has_many :categories, through: :category_sales
  has_many :photos

  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :prep_days
end
