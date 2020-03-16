require 'rails_helper'

RSpec.describe 'Model Micropost', type: :model do
  before do
    init_db_test
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

  describe 'Destroy Micropost' do
    it 'Success' do
      user = FactoryBot.create(:user)
      expect(Micropost.where(user_id: user.id).length).to be >= 1
      micropost_count = Micropost.where(user_id: user.id).length

      Micropost.find_by(user_id: user.id).destroy
      expect(Micropost.where(user_id: user.id).length).to eq micropost_count - 1
    end

    it 'Depends its user' do
      user = FactoryBot.create(:user)
      expect(Micropost.where(user_id: user.id).length).to be >= 1

      User.find(user.id).destroy
      expect(Micropost.where(user_id: user.id).length).to be == 0
    end
  end

  describe 'Alignment Sequence' do
    it "In descending order" do
      count = @microposts.length

      @microposts.each do |micropost|
        count -= 1
        expect(micropost.id).to be > count
      end
    end
  end
end
