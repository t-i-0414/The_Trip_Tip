# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Sessions', type: :feature do
  before do
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
      expect(page).to have_css 'div.wrapper_pagenate.top'
      expect(page).to have_css 'div.wrapper_pagenate.bottom'

      @users.each do |user|
        expect(page).to have_link 'ユーザーのアイコン', href: user_path(id: user.id)
        expect(page).to have_link user.name, href: user_path(id: user.id)
      end
    end
  end
end
