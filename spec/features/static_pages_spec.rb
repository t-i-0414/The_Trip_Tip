# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Static Pages', type: :feature do
  feature 'Should render right templates' do
    scenario 'Home' do
      visit root_path
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('')
    end

    scenario 'About' do
      visit about_path
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('The Trip Tipについて')
    end

    scenario 'Terms of Use' do
      visit terms_of_use_path
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('利用規約')
    end

    scenario 'Privacy' do
      visit privacy_path
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('プライバシーポリシー')
    end
  end

  feature 'Should have right links' do
    background do
      visit root_path
    end

    scenario 'Header' do
      expect(page).to have_link 'The Trip Tipのロゴ', href: root_path
      expect(page).to have_link 'ユーザー登録', href: new_user_registration_path, count: 2
      expect(page).to have_link 'ログイン', href: new_user_session_path, count: 2
      # 以下はまだ未実装
      # 投稿一覧のリンク
      # ログイン後のリンク集
    end

    scenario 'Footer' do
      expect(page).to have_link 'The Trip Tipについて', href: about_path
      expect(page).to have_link '利用規約', href: terms_of_use_path
      expect(page).to have_link 'プライバシーポリシー', href: privacy_path
    end
  end

  feature 'Should render right error pages' do
    scenario '404' do
      visit '/tasks/404test'
      expect(page).to have_title full_title('404 Not Found')
      expect(page).to have_http_status 404
    end

    scenario '500' do
      expect_any_instance_of(StaticPagesController).to receive(:about).and_throw(Exception)
      visit about_path
      expect(page).to have_title full_title('500 Internal Server Error')
      expect(page).to have_http_status 500
    end
  end
end
