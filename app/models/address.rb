class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  # 郵便番号（ハイフンあり7桁）
  VALID_POSTAL_REGEX = /\A\d{3}[-]\d{4}\z/
  # 全て数値（ーあり全角数字）
  VALID_NUMBER_REGEX = /\A[０-９,ー]+\z/
  # 携帯番号(ハイフンなし10桁or11桁)
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  # 全角ひらがなカタカナ数字
  VALID_ADDRESS_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々]|[０-９])+\z/ 

  validates :postal_code,  presence: true,   format:{ with: VALID_POSTAL_REGEX }
  
  validates :city,         presence: true,   format:{ with: VALID_ADDRESS_REGEX }
  validates :block_number, presence: true,   format:{ with: VALID_NUMBER_REGEX }
  validates :phone_number,                   format:{ with: VALID_PHONE_REGEX }  ,  allow_blank: true
  validates :building,                       format:{ with: VALID_ADDRESS_REGEX },  allow_blank: true
end
