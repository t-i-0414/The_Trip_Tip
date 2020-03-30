require 'rails_helper'

RSpec.describe 'Model Like', type: :model do
  before :each do
    init_db_test
    @like = Like.create(micropost_id: 1, user_id: 1)
  end

  describe 'Validated Like' do
    it "Valid" do
      expect(@like).to be_valid
    end

    it "Require micropost_id" do
      @like.micropost_id = nil
      expect(@like).not_to be_valid
    end

    it "Require user_id" do
      @like.user_id = nil
      expect(@like).not_to be_valid
    end
  end
end
