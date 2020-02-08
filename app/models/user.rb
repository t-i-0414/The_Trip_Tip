# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable, :timeoutable,
         :omniauthable
  with_options if: proc { |a| a.uid.blank? } do
    validates :name, presence: true, length: { maximum: 32 }
  end

  mount_uploader :image, ImageUploader

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    unless user
      user = User.new(
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[6, 16]
      )
      user.image = auth.info.image.gsub('_normal', '') if user.provider == 'twitter'
      user.image = auth.info.image.gsub('picture', 'picture?type=large') if user.provider == 'facebook'
      user.save
    end
    user
  end
end
