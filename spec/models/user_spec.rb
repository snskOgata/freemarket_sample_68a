require 'rails_helper'
describe User do
  describe '#create' do
    # 1. nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2. nicknameが空だと登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # 3. nicknameが重複した場合、登録できないここと
    it "is invalid with a duplicate nickname" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end

    # 4. emailが空だと登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # 5. emailの@がないと登録できないこと
    it "is invalid without a email of @" do
      user = build(:user, email: "eeegmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    # 6. emailの.がないと登録できないこと
    it "is invalid without a email of ." do
      user = build(:user, email: "eee@gmailcom")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    # 7. passwordがないと登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # 8. emailが重複した場合、登録できないこと
    it "is invalid with a duplicate email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # 9. password_confirmationがpasswordと異なると登録できないこと
    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end

    # 10.passwordが6字だと登録できないこと
    it "is invalid password with a password that has less than 6 characters " do
      user = build(:user, password:"000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    # 11. nicknameが20字なら登録できること
    it "is valid with a nickname of 20 " do
      user = build(:user, nickname: "01234567890123456789")
      user.valid?
      expect(user).to be_valid
    end

    # 12. nicknameが21字だと登録できないこと
    it "is invalid with a nickname of 21" do
      user = build(:user, nickname: "012345678901234567890")
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end
  end
end