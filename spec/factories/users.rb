FactoryBot.define do
  sequence(:name, 'user-1')
  sequence(:email, 'user-1@example.com')
  sequence(:name_auth, 'auth-1')
  sequence(:email_auth, 'auth-1@example.com')
  sequence(:uid, '1')

  factory :user do
    name { generate :name }
    email { generate :email }
    password {'password'}

    after(:create) do |user|
      count = -1
      5.times do
        count += 1
        create(:micropost,user: user, created_at: Time.current + count.days, updated_at: Time.current + count.days)
      end
    end
  end

  factory :user_auth, class: User do
    name { generate :name_auth }
    email { generate :email_auth }
    password {'password'}
    uid { generate :uid}

    after(:create) do |user|
      count = -1
      5.times do
        count += 1
        create(:micropost,user: user, created_at: Time.current + count.days, updated_at: Time.current + count.days)
      end
    end
  end
end
