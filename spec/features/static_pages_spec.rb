# frozen_string_literal: true

require 'rails_helper'

describe 'Home' do
  specify '画面の表示' do
    visit '/static_pages/home'
    expect(page).to have_title('トップ | The Trip Tip')
  end
end

describe 'signup' do
  specify '画面の表示' do
    visit '/static_pages/signup'
    expect(page).to have_title('ユーザー登録 | The Trip Tip')
  end
end

describe 'login' do
  specify '画面の表示' do
    visit '/static_pages/login'
    expect(page).to have_title('ログイン | The Trip Tip')
  end
end

describe 'unlock_user' do
  specify '画面の表示' do
    visit '/static_pages/unlock_user'
    expect(page).to have_title('アカウントのロック解除リクエスト | The Trip Tip')
  end
end

describe 'rest_password' do
  specify '画面の表示' do
    visit '/static_pages/rest_password'
    expect(page).to have_title('パスワードのリセットリクエスト | The Trip Tip')
  end
end

describe 'about' do
  specify '画面の表示' do
    visit '/static_pages/about'
    expect(page).to have_title('The Trip Tipについて | The Trip Tip')
  end
end

describe 'terms_of_use' do
  specify '画面の表示' do
    visit '/static_pages/terms_of_use'
    expect(page).to have_title('利用規約 | The Trip Tip')
  end
end

describe 'privacy' do
  specify '画面の表示' do
    visit '/static_pages/privacy'
    expect(page).to have_title('プライバシーポリシー | The Trip Tip')
  end
end
