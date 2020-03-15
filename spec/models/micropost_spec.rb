require 'rails_helper'

RSpec.describe 'Model Micropost', type: :model do
  before do
    init_db_test
  end

  describe 'Validated Micropost' do
    it "Valid" do
      # user = FactoryBot.build(:user)
      # expect(user).to be_valid
    end
  end
end
