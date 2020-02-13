FactoryBot.define do
  factory(:user) do
    sequence(:email) { |n| "user-#{n}@example.com" }
    sequence(:password) {'123456'}
  end
end
