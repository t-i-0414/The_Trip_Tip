# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Sessions', type: :feature do
  before(:each) do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'Before login' do
      visit user_index_path
      
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end
    
    scenario 'After login' do
      visit new_user_session_path
      login(@user)
      
      visit user_index_path
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー一覧')
      
    end
  end
end
