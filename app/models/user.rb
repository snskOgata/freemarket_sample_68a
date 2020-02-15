class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  has_many :sales
  has_many :orders
  has_many :credits,     dependent: :destroy
  has_one  :profile,     dependent: :destroy
  accepts_nested_attributes_for :profile
  has_one  :address,dependent: :destroy
  accepts_nested_attributes_for :address
end
