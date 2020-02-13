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
  has_one  :user_address,dependent: :destroy
end
