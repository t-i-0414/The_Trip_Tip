# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Static Pages', type: :feature do
  before :each do
    init_db_test
  end

  feature 'Render right templates' do
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

  feature 'Have right links' do
    background do
      visit root_path
    end

    scenario 'Header(bofore login)' do
      expect(page.find('header')).to have_link 'The Trip Tipのロゴ', href: root_path

      expect(page.find('header')).to have_link '投稿一覧', href: micropost_index_path, count: 2
      expect(page.find('header')).to have_link 'ユーザー登録', href: new_user_registration_path, count: 2
      expect(page.find('header')).to have_link 'ログイン', href: new_user_session_path, count: 2

      expect(page.find('input.unshown#nav-input')[:type]).to eq 'checkbox'
      expect(page.find('label.nav-close#nav-close')[:for]).to eq 'nav-input'
      expect(page.find('label.nav-open#nav-open')[:for]).to eq 'nav-input'
    end

    scenario 'Header(after login)' do
      login(@user)

      expect(page.find('label.user_detail_open#userDetailOpen')[:for]).to eq 'userDetailInput'
      expect(page.find('#userDetailOpen').find('img')[:src]).to eq @user.image.url

      expect(page.find('header')).to have_link 'The Trip Tipのロゴ', href: user_path(@user.id)

      expect(page.find('header')).to have_link 'タイムライン', href: user_timeline_path(id: @user.id), count: 2
      expect(page.find('header')).to have_link 'ユーザー一覧', href: user_index_path, count: 2
      expect(page.find('header')).to have_link '設定', href: edit_user_registration_path, count: 2
      expect(page.find('header')).to have_link 'ログアウト', href: destroy_user_session_path, count: 2

      expect(page.find('input.unshown#nav-input')[:type]).to eq 'checkbox'
      expect(page.find('label.nav-close#nav-close')[:for]).to eq 'nav-input'
      expect(page.find('label.nav-open#nav-open')[:for]).to eq 'nav-input'
    end

    scenario 'Footer' do
      expect(page.find('footer')).to have_link 'The Trip Tipについて', href: about_path
      expect(page.find('footer')).to have_link '利用規約', href: terms_of_use_path
      expect(page.find('footer')).to have_link 'プライバシーポリシー', href: privacy_path
    end
  end

  feature 'Render right error pages' do
    scenario '404' do
      visit '/tasks/404test'
      expect(page).to have_title full_title('404 Not Found')
      expect(page).to have_http_status 404
      expect(page.find('h1')).to have_content '404 Not Found'
      expect(page).to have_link '前のページに戻る', href: 'javascript:history.back()'
      expect(page).to have_link 'トップページへ', href: root_path
    end

    scenario '500' do
      expect_any_instance_of(StaticPagesController).to receive(:about).and_throw(Exception)
      visit about_path
      expect(page).to have_title full_title('500 Internal Server Error')
      expect(page).to have_http_status 500
      expect(page.find('h1')).to have_content '500 Internal Server Error'
      expect(page).to have_link '前のページに戻る', href: 'javascript:history.back()'
      expect(page).to have_link 'トップページへ', href: root_path
    end
  end
end
