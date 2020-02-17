require 'rails_helper'
describe Address do
  describe '#create' do
    # 1. postal_code, prefecture_id, city, block_number, phone_number, buildingが存在すれば登録できること
    it "is valid with a postal_code, prefecture_id, city, block_number, phone_number, building" do
      address = build(:address)
      expect(address).to be_valid
    end
  
    # 2. postal_codeが空だと登録できないこと
    it "is invalid without a postal_code" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    # 3. prefecture_idが空だと登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: "")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("can't be blank")
    end

    # 4. cityが空だと登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    # 5. block_numberが空だと登録できないこと
    it "is invalid without a block_number" do
      address = build(:address, block_number: "")
      address.valid?
      expect(address.errors[:block_number]).to include("can't be blank")
    end

    # 6. phone_numberが空でも登録できること
    it "is valid without a phone_number" do
      address = build(:address, phone_number: "")
      address.valid?
      expect(address).to be_valid
    end

    # 7. buildingが空でも登録できること
    it "is valid without a building" do
      address = build(:address, building: "")
      address.valid?
      expect(address).to be_valid
    end

    # 8. postal_codeが123-123だと登録できないこと
    it "is invalid with that postal_code value 123-123" do
      address = build(:address, postal_code: "123-123")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end

    # 9. postal_codeが123-12345だと登録できないこと
    it "is invalid with that postal_code value 123-12345" do
      address = build(:address, postal_code: "123-12345")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end
    
    # 10. postal_codeが12-1234だと登録できないこと
    it "is invalid with that postal_code value 12-1234" do
      address = build(:address, postal_code: "12-1234")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end

    # 11. postal_codeが1234-1234だと登録できないこと
    it "is invalid with that postal_code value 1234-1234" do
      address = build(:address, postal_code: "1234-1234")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end

    # 12. postal_codeが1234-1234だと登録できないこと
    it "is invalid with that postal_code value 1231234" do
      address = build(:address, postal_code: "1231234")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end

    # 13. prefecture_idが0以下だと登録できないこと
    it "is invalid with that prefecture_id value 0" do
      address = build(:address, prefecture_id: "0")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("must be greater than 0")
    end

    # 13. prefecture_idが48以上だと登録できないこと
    it "is invalid with that prefecture_id value 48" do
      address = build(:address, prefecture_id: "48")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("must be less than 48")
    end

    # 14. prefecture_idが1だと登録できないこと
    it "is valid with that prefecture_id value 1" do
      address = build(:address, prefecture_id: "1")
      address.valid?
      expect(address).to be_valid
    end

    # 15. prefecture_idが48以上だと登録できないこと
    it "is valid with that prefecture_id value 47" do
      address = build(:address, prefecture_id: "47")
      address.valid?
      expect(address).to be_valid
    end

    # 16. phone_numberが123456789だと登録できないこと
    it "is invalid with that phone_number value 123456789" do
      address = build(:address, phone_number: "123456789")
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid")
    end

    # 17. phone_numberが0123456789だと登録できること
    it "is invalid with that phone_number value 0123456789" do
      address = build(:address, phone_number: "0123456789")
      address.valid?
      expect(address).to be_valid
    end

    # 18. phone_numberが012345678901だと登録できないこと
    it "is invalid with that phone_number value 012345678901" do
      address = build(:address, phone_number: "012345678901")
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid")
    end

    # 19. phone_numberが012-3456-7890だと登録できないこと
    it "is invalid with that phone_number value 012-3456-7890" do
      address = build(:address, phone_number: "012-3456-789")
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid")
    end

    # 20. phone_numberが全角だと登録できないこと
     it "is invalid with Full-width" do
      address = build(:address, phone_number: "０９０１２３４５６７８９")
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid")
    end

  end
end