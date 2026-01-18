FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    category { "MyString" }
    user { nil }
  end
end
