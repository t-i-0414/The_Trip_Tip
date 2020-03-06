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

      @pagenate_count.times do |num|
        expect(page).to have_link 'ユーザーのアイコン', href: user_path(id: @users[num].id)
        expect(page).to have_link @users[num].name, href: user_path(id: @users[num].id)
      end

      expect(page).to have_no_link 'ユーザーのアイコン', href: user_path(id: @users[@pagenate_count].id)
      expect(page).to have_no_link @users[@pagenate_count].name, href: user_path(id: @users[@pagenate_count].id)
    end
  end
end
