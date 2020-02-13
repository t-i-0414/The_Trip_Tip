# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
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
end
