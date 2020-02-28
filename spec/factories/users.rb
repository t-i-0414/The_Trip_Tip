FactoryBot.define do
  sequence :name do |i|
    "user-#{i}"
  end
  
  sequence :email do |i|
    "user-#{i}@example.com"
  end

  factory :user do
    name { generate :name }
    email { generate :email }
    password {'password'}
  end
end
