# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable, :timeoutable,
         :omniauthable
  with_options if: proc { |a| a.uid.blank? } do |a|
    a.validates :name, presence: true
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
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
