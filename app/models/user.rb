class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 20 }
  
  has_many :sns_credentials
  has_many :sales, class_name: 'Sale', foreign_key: 'seller_id'
  has_many :orders, class_name: 'Order', foreign_key: 'buyer_id'
  has_many :cards,   dependent: :destroy
  has_one  :profile, dependent: :destroy
  has_one  :address, dependent: :destroy

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :address

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
