require 'rails_helper'

RSpec.describe 'Model User', type: :model do
  it "Valid" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "Invalid with no name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "Invalid with 33 letters name" do
    user = FactoryBot.build(:user, name: "#{'a' * 33}")
    user.valid?
    expect(user.errors[:name]).to include("は32文字以内で入力してください")
  end

  it "Invalid with no email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "Invalid with wrong email" do
    user = FactoryBot.build(:user, email: "notEmail")
    user.valid?
    expect(user.errors[:email]).to include("は有効でありません。")
  end

  it "Invalid with duplicated email" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, email: "#{user1.email}")
    user2.valid?
    expect(user2.errors[:email]).to include("は既に使用されています。")
  end

  it "Invalid with no email with no password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  it "Invalid with no email with password less than 6" do
    user = FactoryBot.build(:user, password: "12345")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
  end

  it "Invalid with no email with password more than 16" do
    user = FactoryBot.build(:user, password: "12345123451234567")
    user.valid?
    expect(user.errors[:password]).to include("は16文字以下に設定して下さい。")
  end

  it "Confirmation encrypted password" do
    user = FactoryBot.create(:user)
    expect(user.encrypted_password).to_not eq "password"
  end
end
