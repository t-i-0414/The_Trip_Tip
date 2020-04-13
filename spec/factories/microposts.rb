# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { "#{'a' * 140}" }
    user
  end
end
