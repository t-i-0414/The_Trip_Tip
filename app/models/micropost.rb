# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, class_name: 'Like', foreign_key: 'micropost_id', dependent: :destroy
  has_many :likes_user, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  mount_uploader :image, ImageUploader
  mount_base64_uploader :image, ImageUploader
end
