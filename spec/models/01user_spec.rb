# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Model User', type: :model do
  describe 'Validated User' do
    it "Valid" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  describe 'Invalidated User(name)' do
    it "No name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "More than 32 characters" do
      user = FactoryBot.build(:user, name: "#{'a' * 33}")
      user.valid?
      expect(user.errors[:name]).to include("は32文字以内で入力してください")
    end
  end

  describe 'Invalidated User(email)' do
    it "No email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it "Wrong email" do
      user = FactoryBot.build(:user, email: "notEmail")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")

      user = FactoryBot.build(:user, email: "not@email")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")

      user = FactoryBot.build(:user, email: "not@email..com")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")

      user = FactoryBot.build(:user, email: "not@email.com.")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")

      user = FactoryBot.build(:user, email: "not★@email.com")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
    end

    it "Duplicated email" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user, email: "#{user1.email}")
      user2.valid?
      expect(user2.errors[:email]).to include("は既に使用されています。")
      user3 = FactoryBot.build(:user, email: "#{user1.email.upcase}")
      user3.valid?
      expect(user3.errors[:email]).to include("は既に使用されています。")
    end

    it "Confirmation downcase email" do
      user = FactoryBot.create(:user, email: "TEST@EXAMPLE.COM")
      expect(user.email).to eq "test@example.com"
    end
  end


  describe 'Invalidated User(password)' do
    it "No password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "Less than 6 characters" do
      user = FactoryBot.build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    it "More than 16 characters" do
      user = FactoryBot.build(:user, password: "12345123451234567")
      user.valid?
      expect(user.errors[:password]).to include("は16文字以下に設定して下さい。")
    end

    it "Confirmation encrypted password" do
      user = FactoryBot.create(:user)
      expect(user.encrypted_password).to_not eq "password"
    end
  end

  describe 'Destroy User' do
    it 'Destroy with its microposts' do
      user = FactoryBot.create(:user)
      expect(Micropost.where(user_id: user.id).length).to be >= 1

      User.find(user.id).destroy
      expect(Micropost.where(user_id: user.id).length).to be == 0
    end
  end

  describe 'Alignment Sequence' do
    it "In descending order" do
      count = -1
      20.times do
        count += 1
        FactoryBot.create(:user, created_at: Time.current + count.days, updated_at: Time.current + count.days, confirmed_at: Time.current + count.days)
      end

      users_all = User.all
      count = users_all.length

      users_all.each do |user|
        count -= 1
        expect(user.id).to be > count
      end
    end
  end

  describe 'Follow Actions' do
    it "Follow" do
      init_db_test
      follower = @users[0]
      followed = @users[1]

      expect(follower.following?(followed)).to be false
      expect(followed.followers.include?(follower)).to be false

      follower.follow(followed)
      expect(follower.following?(followed)).to be true
      expect(followed.followers.include?(follower)).to be true
    end

    it "Unfollow" do
      init_db_test
      follower = @users[0]
      followed = @users[1]

      expect(follower.following?(followed)).to be false
      expect(followed.followers.include?(follower)).to be false

      follower.follow(followed)
      expect(follower.following?(followed)).to be true
      expect(followed.followers.include?(follower)).to be true

      follower.unfollow(followed)
      expect(follower.following?(followed)).to be false
      expect(followed.followers.include?(follower)).to be false
    end
  end
end
