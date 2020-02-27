class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 20 }
  
  has_many :sales, class_name: 'Sale', foreign_key: 'seller_id'
  has_many :orders, class_name: 'Order', foreign_key: 'buyer_id'
  has_many :cards,   dependent: :destroy
  has_one  :profile, dependent: :destroy
  has_one  :address, dependent: :destroy

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :address
end
