class Sale < ApplicationRecord
 
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :detail, :condition_id, :delivery_payer_id, 
    :prefecture_id, :prep_days_id, :price, :status, presence: true
  validates :name, length: { maximum: 40 }
  validates :detail, length: { maximum: 1000 }
  validate :check_categories
  validate :check_photos

  enum status: { on_sale: 0, shipping: 1, soldout: 2}

  has_many :category_sales, dependent: :destroy
  has_many :categories, through: :category_sales
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :prep_days

  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  has_one :order 

  def check_categories
    errors.add(:categories, "は1つ以上指定して下さい") if categories.size < 1
  end

  def check_photos
    errors.add(:photos, "は1枚以上10枚以下が必須です") if photos.size < 1
  end
end
