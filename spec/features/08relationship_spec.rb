# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Relationship', type: :feature do
  before :each do
    init_db_test
    @active_relationship = Relationship.create(follower_id: @users[0].id, followed_id: @users[1].id)
    @passive_relationship = Relationship.create(follower_id: @users[1].id, followed_id: @users[0].id)
  end

  feature 'Render right contents' do
    scenario 'Before login' do
      visit followers_user_path(@user)

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'

      visit following_user_path(@user)

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'
    end

    scenario 'After login' do
      login(@user)
      visit followers_user_path(@user)

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('フォロワー一覧')
      expect(page).to have_content @users[1].name
      expect(page).not_to have_content @users[2].name

      visit following_user_path(@user)

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('フォロー一覧')
      expect(page).to have_content @users[1].name
      expect(page).not_to have_content @users[2].name
    end
  end

  feature 'Relationship action' do
    scenario 'Create relationship' do
      login(@users[0])
      @active_relationship.destroy

      visit user_path @users[1]

      expect { click_button 'フォローする', match: :first }.to change { Relationship.count }.by(1)
      expect(page).to have_content '1'
    end

    scenario 'Destroy relationship' do
      login(@users[0])

      visit user_path @users[1]

      expect { click_button 'フォローしない', match: :first }.to change { Relationship.count }.by(-1)
      expect(page).to have_content '0'
    end
  end
end
