FactoryBot.define do
  factory :micropost do
    content { 'comment' }
    user
  end
end
