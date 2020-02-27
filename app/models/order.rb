class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id', optional: true
  belongs_to :sale,                      foreign_key: true,       optional: true
end
