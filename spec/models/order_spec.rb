require 'rails_helper'
describe Order do
  describe '#create' do
    it "buyer_idとsale_idがあれば保存できる" do
      user = create(:user, id: 1)
      sale = create(:sale, id: 1)
      order = build(:order)
      expect(order).to be_valid
    end

    it "buyer_idが空だと保存できない" do
      user = create(:user, id: 1)
      sale = create(:sale, id: 1)
      order = build(:order, buyer_id: "")
      order.valid?
      expect(order.errors[:buyer_id]).to include("を入力してください")
    end

    it "sale_idが空だと保存できない" do
      user = create(:user, id: 1)
      sale = create(:sale, id: 1)
      order = build(:order, sale_id: "")
      order.valid?
      expect(order.errors[:sale_id]).to include("を入力してください")
    end

    it "sale_idが重複すると保存できない(バリデーションエラーが起こる)" do
      expect do
      user = create(:user, id: 1)
      sale = create(:sale, id: 1) 
      order1 = create(:order, sale_id: 1)
      order2 = create(:order, sale_id: 1)
      end.to raise_error( ActiveRecord::RecordInvalid )
    end

    it "buyer_idが重複しても保存できる" do
      sale1 = create(:sale, id: 1) 
      sale2 = create(:sale, id: 2)
      user = create(:user, id: 1)
      order1 = create(:order, buyer_id: 1, sale_id: 1)
      order2 = build(:order, buyer_id: 1, sale_id: 2)
      expect(order2).to be_valid
    end

  end
end