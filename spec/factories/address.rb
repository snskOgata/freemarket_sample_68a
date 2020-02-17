FactoryBot.define do

  factory :address do
    postal_code         {"123-1234"}
    prefecture_id       {"10"}
    city                {"渋谷市"}
    block_number        {"渋谷１ー１ー１"}
    phone_number        {"09012345678"}
    building            {"渋谷マンション１２３号室"}
  end

end