FactoryBot.define do
  factory :photo do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.png'), 'image/png') }
  end
end