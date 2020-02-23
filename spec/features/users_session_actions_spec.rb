# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Session Actions', type: :feature do
  # ビューの内容は正しいか（ログイン後のユーザー詳細ページの内容も要確認）
  feature 'Should render right templates' do
    before(:each) do
      users = FactoryBot.build_list(:user, 10, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
      User.insert_all users.map(&:attributes)
      @user = User.find_by(id: 1)
      visit new_user_session_path
    end
    scenario 'Before login' do
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_link('twitterでログイン', href: '/users/auth/twitter')
      expect(page).to have_link('Facebookでログイン', href: '/users/auth/facebook')
    end
    scenario 'After login' do
      login(@user)
      expect(page).to have_http_status 200
      expect(page).to have_title full_title("#{@user.name}")
    end
    scenario 'Successful login' do
      login(@user)
      expect(page).to have_content 'ログインしました。'
    end
    scenario 'Failed login' do
      fill_in 'user[email]', with: 'failed@example.com'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'passward'
      click_button 'ログイン'
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
    end
  end

  # 間違ったメールアドレスやパスワードの場合を処理できるか（リダイレクト先、フラッシュも要確認）
  # ログイン前とログイン後のヘッダーのリンク表示や数は正しいか
  # ログイン後はトップページに飛ばさせない（URLの直打ちに対応、リダイレクト先要確認）
  # 違うユーザーの詳細ページに飛ばさせない（URLの直打ちに対応、リダイレクト先要確認）
  # ログアウトは正常にできるか（リダイレクト先、フラッシュも要確認）
end
