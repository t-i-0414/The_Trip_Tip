# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'The Trip Tip'
  end

  test 'should get home' do
    get root_url
    assert_response :success, @response.body
    assert_select 'title', @base_title.to_s
  end

  test 'should get about' do
    get about_url
    assert_response :success, @response.body
    assert_select 'title', "The Trip Tipについて | #{@base_title}"
  end

  test 'should get terms_of_use' do
    get terms_of_use_url
    assert_response :success, @response.body
    assert_select 'title', "利用規約 | #{@base_title}"
  end

  test 'should get privacy' do
    get privacy_url
    assert_response :success, @response.body
    assert_select 'title', "プライバシーポリシー | #{@base_title}"
  end
end
