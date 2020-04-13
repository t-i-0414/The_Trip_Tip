# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Like', type: :feature do
  before :each do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'Before login' do
      visit micropost_index_path

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('投稿一覧')

      click_on 'いいねのアイコン', match: :first

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'
    end
  end

  feature 'Like action' do
    scenario 'Like' do
      login(@user)
      visit root_path

      expect { click_on 'いいねのアイコン', match: :first }.to change { Like.count }.by(1)

      visit root_path

      expect(page).to have_link 'いいねのアイコン', href: likes_delete_path(micropost_id: Like.last.micropost_id), count: 1
    end

    scenario 'Unlike' do
      login(@user)
      visit root_path
      click_on 'いいねのアイコン', match: :first
      micropost_id = Like.last.micropost_id

      visit root_path
      expect { click_on 'いいねのアイコン', match: :first }.to change { Like.count }.by(-1)

      visit root_path
      expect(page).to have_link 'いいねのアイコン', href: likes_create_path(micropost_id: micropost_id), count: 1
    end
  end
end
