class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  # 郵便番号（ハイフンあり7桁）
  VALID_POSTAL_REGEX = /\A\d{3}[-]\d{4}\z/
  # 携帯番号(ハイフンなし10桁or11桁)
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  # 全角ひらがなカタカナ数字(ー) 半角英数(-)
  VALID_ADDRESS_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々]|[０-９]|[0-9]|[a-z]|[-])+\z/ 

  validates :postal_code,   presence: true, format:{ with: VALID_POSTAL_REGEX }
  validates :prefecture_id, presence: true, numericality: { greater_than: 0, less_than: 48 }
  validates :city,          presence: true, format:{ with: VALID_ADDRESS_REGEX }
  validates :block_number,  presence: true, format:{ with: VALID_ADDRESS_REGEX }
  validates :phone_number,                  format:{ with: VALID_PHONE_REGEX }  , allow_blank: true
  validates :building,                      format:{ with: VALID_ADDRESS_REGEX }, allow_blank: true
end
