require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get signup" do
    get static_pages_signup_url
    assert_response :success
  end

  test "should get login" do
    get static_pages_login_url
    assert_response :success
  end

  test "should get unlock_user" do
    get static_pages_unlock_user_url
    assert_response :success
  end

  test "should get rest_password" do
    get static_pages_rest_password_url
    assert_response :success
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

  test "should get terms_of_use" do
    get static_pages_terms_of_use_url
    assert_response :success
  end

  test "should get privacy" do
    get static_pages_privacy_url
    assert_response :success
  end

  test "should get error_404" do
    get static_pages_error_404_url
    assert_response :success
  end

  test "should get error_500" do
    get static_pages_error_500_url
    assert_response :success
  end

end
