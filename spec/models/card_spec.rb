require 'rails_helper'
describe Card do
  describe '#create' do
    it "customer_idとcard_idがあれば保存できる", focus: false do
      card = build(:card)
      expect(card).to be_valid
    end

    it "customer_idが空だと保存できない", focus: false do
      card = build(:card, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idが空だと保存できない", focus: false do
      card = build(:card, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end

    it "user_idが空だと保存できない", focus: false do
      card = build(:card, user_id: "")
      card.valid?
      expect(card.errors[:user_id]).to include("を入力してください")
    end

  end
end