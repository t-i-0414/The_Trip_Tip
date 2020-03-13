# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Unlock Account', type: :feature do
  before do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'Unclock Account Page' do
      visit new_user_unlock_path

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('アカウントロック解除')
      expect(page).to have_selector 'h1', text: 'アカウントロックの解除'
    end
  end

  feature 'Unlock Account' do
    scenario 'Success' do
      visit new_user_session_path

      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'passward'
      click_button 'ログイン', match: :first

      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'passward'
      click_button 'ログイン', match: :first

      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'passward'
      click_button 'ログイン', match: :first

      visit new_user_unlock_path

      fill_in 'user[email]', with: @user.email
      click_button '送    信', match: :first
      expect(page).to have_content 'アカウントの凍結解除方法を数分以内にメールでご連絡します'

      visit_unlock_account

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'
      expect(page).to have_content 'アカウントを凍結解除しました。'
    end

    scenario 'Fail' do
      visit new_user_unlock_path

      fill_in 'user[email]', with: @user.email
      click_button '送    信', match: :first
      expect(page).to have_content 'メールアドレスは凍結されていません。'

      expect(page).to have_title full_title('アカウントロック解除')
      expect(page).to have_selector 'h1', text: 'アカウントロックの解除'
    end
  end
end
