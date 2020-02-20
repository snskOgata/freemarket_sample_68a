class Sale < ApplicationRecord
 
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :detail, :condition_id, :delivery_payer_id, 
    :prefecture_id, :prep_days_id, :price, :status, presence: true
  validates :name, length: { maximum: 40 }
  validates :detail, length: { maximum: 1000 }

  enum status: { on_sale: 0, soldout: 1 }

  has_many :category_sales
  has_many :categories, through: :category_sales
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :prep_days

  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
end
