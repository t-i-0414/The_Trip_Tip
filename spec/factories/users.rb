FactoryBot.define do
  factory(:user) do
    sequence(:name) {|n| "user-#{n}"}
    sequence(:email) { |n| "user-#{n}@example.com" }
    sequence(:password) {'password'}
  end
end
