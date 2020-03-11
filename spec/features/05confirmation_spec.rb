# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Confirmations', type: :feature do
  before do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'New confirmation' do
      visit new_user_confirmation_path

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー認証メールの再送信')
      expect(page).to have_selector 'h1', text: 'ユーザー認証メールの再送信'
    end
    
    scenario 'Resend confirmation' do
      user = {
        name: 'test',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      
      visit new_user_registration_path
      fill_in 'user[name]', with: user[:name]
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password_confirmation]
      click_button 'ユーザー登録', match: :first
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    
      visit new_user_confirmation_path
      fill_in 'user[email]', with: user[:email]
      click_button '送    信', match: :first
      expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'
    end
  end
end
