# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'The Trip Tip'
  end

  test 'should get home' do
    get static_pages_home_url
    assert_response :success, @response.body
    assert_select 'title', @base_title.to_s
  end

  test 'should get signup' do
    get static_pages_signup_url
    assert_response :success
    assert_select 'title', "ユーザー登録 | #{@base_title}"
  end

  test 'should get login' do
    get static_pages_login_url
    assert_response :success, @response.body
    assert_select 'title', "ログイン | #{@base_title}"
  end

  test 'should get unlock_user' do
    get static_pages_unlock_user_url
    assert_response :success, @response.body
    assert_select 'title', "アカウントのロック解除リクエスト | #{@base_title}"
  end

  test 'should get reset_password' do
    get static_pages_reset_password_url
    assert_response :success, @response.body
    assert_select 'title', "パスワードのリセットリクエスト | #{@base_title}"
  end

  test 'should get about' do
    get static_pages_about_url
    assert_response :success, @response.body
    assert_select 'title', "The Trip Tipについて | #{@base_title}"
  end

  test 'should get terms_of_use' do
    get static_pages_terms_of_use_url
    assert_response :success, @response.body
    assert_select 'title', "利用規約 | #{@base_title}"
  end

  test 'should get privacy' do
    get static_pages_privacy_url
    assert_response :success, @response.body
    assert_select 'title', "プライバシーポリシー | #{@base_title}"
  end
end
