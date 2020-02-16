class Profile < ApplicationRecord
  belongs_to :user, optional: true

  # 全角ひらがなカタカナ
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/ 
  # 全角カタカナ
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/

  validates :lastname,       presence: true, format: { with: VALID_NAME_REGEX }
  validates :firstname,      presence: true, format: { with: VALID_NAME_REGEX }
  validates :lastname_kana,  presence: true, format: { with: VALID_KANA_REGEX }
  validates :firstname_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :birthday,       presence: true

end
