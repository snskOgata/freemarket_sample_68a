require 'rails_helper'

RSpec.describe SnsCredential, type: :model do
  describe do
    it "providerが空だと保存されない" do
      sns_user = build(:sns_credential, provider: "")
      sns_user.valid?
      expect(sns_user.errors[:provider]).to include("を入力してください")
    end
  end

  describe do
    it "uidが空だと保存されない" do
      sns_user = build(:sns_credential, uid: "")
      sns_user.valid?
      expect(sns_user.errors[:uid]).to include("を入力してください")
    end
  end

  describe  do
    it "外部キーが空でもDBに保存される" do
      sns_user = build(:sns_credential)
      expect(sns_user).to be_valid 
    end
  end
end