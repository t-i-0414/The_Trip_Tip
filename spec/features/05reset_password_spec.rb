# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Reset Password', type: :feature do
  before :each do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'New Password' do
      visit new_user_password_path

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('パスワード再発行')
      expect(page).to have_selector 'h1', text: 'パスワードの再発行'
    end
  end

  feature 'Reset Password' do
    scenario 'Success' do
      visit new_user_password_path

      fill_in 'user[email]', with: @user.email
      click_button '送    信', match: :first
      expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'

      visit_edit_password

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('パスワード再設定')
      expect(page).to have_selector 'h1', text: 'パスワード再設定'

      fill_in 'user[password]', with: 'password2'
      fill_in 'user[password_confirmation]', with: 'password2'
      click_button 'パスワードを変更', match: :first
      expect(page).to have_content 'パスワードが正しく変更されました。'
      expect(page).to have_title full_title("#{@user.name}")
    end

    scenario 'Fail' do
      visit new_user_password_path

      fill_in 'user[email]', with: 'failed@example.com'
      click_button '送    信', match: :first
      expect(page).to have_content 'メールアドレスは見つかりませんでした。'
      expect(page).to have_title full_title('パスワード再発行')
      expect(page).to have_selector 'h1', text: 'パスワードの再発行'

      fill_in 'user[email]', with: @user.email
      click_button '送    信', match: :first
      expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'

      visit_edit_password

      fill_in 'user[password]', with: 'password2'
      fill_in 'user[password_confirmation]', with: 'passward2'
      click_button 'パスワードを変更', match: :first
      expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
      expect(page).to have_title full_title('パスワード再設定')
    end

    scenario 'Timeout' do
      visit new_user_password_path

      fill_in 'user[email]', with: @user.email
      click_button '送    信', match: :first
      expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'

      travel_to(6.hour.after + 1.second.after)

      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
    end
  end
end
