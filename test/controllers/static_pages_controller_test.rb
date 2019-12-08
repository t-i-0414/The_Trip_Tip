# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get static_pages_home_url
    assert_response :success, @response.body
    assert_select 'title', 'トップ | The Trip Tip'
  end

  test 'should get signup' do
    get static_pages_signup_url
    assert_response :success
    assert_select 'title', 'ユーザー登録 | The Trip Tip'
  end

  test 'should get login' do
    get static_pages_login_url
    assert_response :success
    assert_select 'title', 'ログイン | The Trip Tip'
  end

  test 'should get unlock_user' do
    get static_pages_unlock_user_url
    assert_response :success
    assert_select 'title', 'アカウントのロック解除リクエスト | The Trip Tip'
  end

  test 'should get rest_password' do
    get static_pages_rest_password_url
    assert_response :success
    assert_select 'title', 'パスワードのリセットリクエスト | The Trip Tip'
  end

  test 'should get about' do
    get static_pages_about_url
    assert_response :success
    assert_select 'title', 'The Trip Tipについて | The Trip Tip'
  end

  test 'should get terms_of_use' do
    get static_pages_terms_of_use_url
    assert_response :success
    assert_select 'title', '利用規約 | The Trip Tip'
  end

  test 'should get privacy' do
    get static_pages_privacy_url
    assert_response :success
    assert_select 'title', 'プライバシーポリシー | The Trip Tip'
  end
end
