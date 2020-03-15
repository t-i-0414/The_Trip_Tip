require 'rails_helper'

RSpec.describe 'Model Micropost', type: :model do
  before do
    init_db_test
    @micropost = FactoryBot.build(:micropost, user_id: @user.id)
  end

  describe 'Validated Micropost' do
    it "Valid" do
      expect(@micropost).to be_valid
    end
  end

  describe 'Invalidated Micropost' do
    it "No user_id" do
      @micropost.user_id = nil
      expect(@micropost).not_to be_valid
      expect(@micropost.errors[:user_id]).to include("作成者のユーザーIDが空欄です。")
    end

    it "No content" do
      @micropost.content = nil
      expect(@micropost).not_to be_valid
      expect(@micropost.errors[:content]).to include("投稿文が入力されていません。")
    end

    it "Content more than 140 characters" do
      @micropost.content = "#{'a' * 141}"
      expect(@micropost).not_to be_valid
      expect(@micropost.errors[:content]).to include("投稿文は140文字以内で入力してください。")
    end
  end
end
