FactoryBot.define do
  factory :card do
    
    customer_id { "MyString" }
    card_id { "MyString" }

    association :user, factory: :user
  end
end
