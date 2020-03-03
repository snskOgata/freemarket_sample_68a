FactoryBot.define do

  # factory :user do
  #   nickname              {"eiichi"}
  #   email                 {"eee@gmail.com"}
  #   password              {"00000000"}
  #   password_confirmation {"00000000"}
  # end

  factory :user do
    password = Faker::Internet.password(8)
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end

end