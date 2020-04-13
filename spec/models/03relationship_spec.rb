# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Model Micropost', type: :model do
  before :each do
    init_db_test
    @relationship = Relationship.create(follower_id: @users[0].id, followed_id: @users[1].id)
  end

  describe 'Validated Relationship' do
    it "Valid" do
      expect(@relationship).to be_valid
    end

    it "Require Follower_id" do
      @relationship.follower_id = nil
      expect(@relationship).not_to be_valid
    end

    it "Require Followed_id" do
      @relationship.followed_id = nil
      expect(@relationship).not_to be_valid
    end
  end
end
