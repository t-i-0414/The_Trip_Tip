# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    follower_id { 1 }
    followed_id { 1 }
  end
end
