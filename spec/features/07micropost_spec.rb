# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Micropost', type: :feature do
  before do
    init_db_test
  end

  feature 'Microposts Index(Before Login)' do
    scenario 'Success' do
      visit micropost_index_path

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('投稿一覧')
      expect(page).to have_css 'div.wrapper_pagenate.top'
      expect(page).to have_css 'div.wrapper_pagenate.bottom'

      if Micropost.count <= @pagenate_count
        expect(page).not_to have_css '.page'
      elsif Micropost.count <= @pagenate_count * @pagenate_maximum
        expect(page).to have_css '.page', count: (Micropost.count.to_f / @pagenate_count).ceil * 2
      else
        expect(page).to have_css '.page', count: @pagenate_maximum * 2
      end
    end

    scenario 'Redirect to login form' do
      visit micropost_index_path

      user_link = page.first('.name_user').first(:link)

      click_on 'ユーザーのアイコン', match: :first

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end
  end
end
