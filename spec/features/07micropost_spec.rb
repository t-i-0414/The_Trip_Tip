# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Micropost', type: :feature do
  before :each do
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

  feature 'Microposts Index(After Login)' do
    scenario 'User root' do
      login(@user)
      microposts = Micropost.where(user_id: @user.id)

      if microposts.length <= @pagenate_count
        expect(page).not_to have_css '.page'
      elsif microposts.length <= @pagenate_count * @pagenate_maximum
        expect(page).to have_css '.page', count: (microposts.length.to_f / @pagenate_count).ceil * 2
      else
        expect(page).to have_css '.page', count: @pagenate_maximum * 2
      end
    end

    scenario 'User root (no post)' do
      until Micropost.where(user_id: @user.id).length == 0 do
        Micropost.find_by(user_id: @user.id).destroy
      end
      login(@user)
      expect(page).to have_content 'まだ投稿がありません'
    end

    scenario 'User show' do
      login(@user)
      microposts = Micropost.where(user_id: @users[1].id)

      visit user_path @users[1]

      if microposts.length <= @pagenate_count
        expect(page).not_to have_css '.page'
      elsif microposts.length <= @pagenate_count * @pagenate_maximum
        expect(page).to have_css '.page', count: (microposts.length.to_f / @pagenate_count).ceil * 2
      else
        expect(page).to have_css '.page', count: @pagenate_maximum * 2
      end
    end

    scenario 'User show (no post)' do
      until Micropost.where(user_id: @users[1].id).length == 0 do
        Micropost.find_by(user_id: @users[1].id).destroy
      end
      login(@user)
      visit user_path @users[1]
      expect(page).to have_content 'まだ投稿がありません'
    end
  end

  feature 'Render right contents' do
    scenario 'Micropost show' do
      login(@user)
      micropost = Micropost.find(1)
      post_user = User.find(micropost.user_id)

      visit micropost_path micropost

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('投稿の詳細')

      expect(page.find('.info_user')).to have_content post_user.name
      expect(page.find('.info_user').find('.image_user')[:src]).to eq post_user.image.url

      expect(page.find('.container_posts').find('.card_post')).to have_link post_user.name, href: user_path(id: post_user.id)
      expect(page.find('.container_posts').find('.card_post')).to have_link 'ユーザーのアイコン', href: user_path(id: post_user.id)

      expect(page).to have_content micropost.content
      # いいねリンクは未実装
    end
  end
end
