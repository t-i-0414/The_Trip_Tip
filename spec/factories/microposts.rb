FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    user { nil }
  end
end
