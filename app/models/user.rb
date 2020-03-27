# frozen_string_literal: true

class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  

  default_scope -> { order(created_at: :desc) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  before_save { self.email = email.downcase }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable, :timeoutable,
         :omniauthable

  with_options if: proc { |a| a.uid.blank? } do
    validates :name, presence: true, length: { maximum: 32 }
    validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  end

  mount_uploader :image, ImageUploader
  mount_base64_uploader :image, ImageUploader

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    unless user
      user = User.new(
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[6, 16],
        remote_image_url: auth.info.image.gsub(/http|_normal|picture/, 'http' => 'https', '_normal' => '', 'picture' => 'picture?type=large')
      )
      user.save
    end
    user
  end
  
  def follow(other_user)
    following << other_user
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
end
