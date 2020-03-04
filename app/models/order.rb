class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id'
  belongs_to :sale,                      foreign_key: true,       optional: true

  validates :buyer_id, presence: true
  validates :sale_id , presence: true, uniqueness: true
end
