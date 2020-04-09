# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :micropost_id, presence: true
  validates :user_id, presence: true
end
