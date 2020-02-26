FactoryBot.define do
  factory :sale do
    name              {"商品名"}
    detail            {"詳細"}
    condition_id      {1}
    delivery_payer_id {1}
    prefecture_id     {1}
    prep_days_id      {1}
    price             {1000}
    association :seller, factory: :user

    after(:build) do |sale|
      sale.categories << create_list(:category, 3)
      sale.photos << create_list(:photo, 3)
    end
  end
end