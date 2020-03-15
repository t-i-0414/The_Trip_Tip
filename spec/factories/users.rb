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
      create_list(:micropost, 5, user: user)
    end
  end

  factory :user_auth, class: User do
    name { generate :name_auth }
    email { generate :email_auth }
    password {'password'}
    uid { generate :uid}

    after(:create) do |user|
      create_list(:micropost, 5, user: user)
    end
  end
end
