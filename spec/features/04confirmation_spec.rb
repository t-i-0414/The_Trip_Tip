# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Confirmations', type: :feature do
  before do
    init_db_test
    
    @test_user = {
      name: 'test',
      email: 'test@example.com',
      failed_email: 'failed@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  feature 'Render right contents' do
    scenario 'New confirmation' do
      visit new_user_confirmation_path

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー認証メールの再送信')
      expect(page).to have_selector 'h1', text: 'ユーザー認証メールの再送信'
    end
  end
  
  feature 'Resend confirmation' do
    scenario 'Success' do
      records_count = User.count

      visit new_user_registration_path
      fill_in 'user[name]', with: @test_user[:name]
      fill_in 'user[email]', with: @test_user[:email]
      fill_in 'user[password]', with: @test_user[:password]
      fill_in 'user[password_confirmation]', with: @test_user[:password_confirmation]
      click_button 'ユーザー登録', match: :first
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

      visit new_user_confirmation_path
      fill_in 'user[email]', with: @test_user[:email]
      click_button '送    信', match: :first
      expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'

      confirmation_email

      expect(User.count).to eq records_count+1
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'ログイン'
    end
    
    scenario 'Fail' do
      records_count = User.count
      
      visit new_user_registration_path
      fill_in 'user[name]', with: @test_user[:name]
      fill_in 'user[email]', with: @test_user[:email]
      fill_in 'user[password]', with: @test_user[:password]
      fill_in 'user[password_confirmation]', with: @test_user[:password_confirmation]
      click_button 'ユーザー登録', match: :first
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

      visit new_user_confirmation_path
      fill_in 'user[email]', with: @test_user[:failed_email]
      click_button '送    信', match: :first
      expect(page).to have_content 'メールアドレスは見つかりませんでした。'

      expect(User.count).to eq records_count+1
      expect(page).to have_title full_title('ユーザー認証メールの再送信')
      expect(page).to have_content 'ユーザー認証メールの再送'
    end
  end
end
