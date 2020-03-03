FactoryBot.define do
  factory :card do
    association :user, factory: :user
    user_id {1}
    customer_id { "MyString" }
    card_id { "MyString" }
  end
end
