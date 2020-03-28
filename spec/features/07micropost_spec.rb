# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Micropost', type: :feature do
  before :each do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'Micropost show (login user)' do
      login(@user)
      post_user = @user
      micropost = Micropost.where(user_id: @user.id)[0]

      visit micropost_path micropost

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('投稿の詳細')

      expect(page.find('.info_user')).to have_content post_user.name
      expect(page.find('.container_posts').find('.card_post')).to have_link post_user.name, href: user_path(id: post_user.id)
      expect(page.find('.info_user').find('.image_user')[:src]).to eq post_user.image.url
      expect(page.find('.container_posts').find('.card_post')).to have_link 'ユーザーのアイコン', href: user_path(id: post_user.id)

      expect(page.find('.container_posts').find('.card_post')).to have_link 'ゴミ箱のアイコン', href: micropost_path(id: micropost.id)

      # いいねボタンについては未実装
    end
    scenario 'Micropost show (other user)' do
      login(@users[10])
      micropost = Micropost.where(user_id: @user.id)[0]
      post_user = User.find(micropost.user_id)

      visit micropost_path micropost

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('投稿の詳細')

      expect(page.find('.info_user')).to have_content post_user.name
      expect(page.find('.container_posts').find('.card_post')).to have_link post_user.name, href: user_path(id: post_user.id)
      expect(page.find('.info_user').find('.image_user')[:src]).to eq post_user.image.url
      expect(page.find('.container_posts').find('.card_post')).to have_link 'ユーザーのアイコン', href: user_path(id: post_user.id)

      expect(page.find('.container_posts').find('.card_post')).not_to have_link 'ゴミ箱のアイコン', href: micropost_path(id: micropost.id)

      # いいねボタンについては未実装
    end
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

  feature 'Timeline' do
    scenario 'Before login' do
      visit user_timeline_path(id: @user)

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end

    scenario 'After login' do
      login(@user)
      active_relationship = Relationship.create(follower_id: @user.id, followed_id: @users[1].id)
      passive_relationship = Relationship.create(follower_id: @users[1].id, followed_id: @user.id)

      visit user_timeline_path(id: @user)
      expect(page).to have_http_status 200
      expect(page).to have_title full_title('タイムライン')

      expect(page).to have_content @user.name, count: 5 + 1
      expect(page).to have_content @users[1].name, count: 5
      expect(page).not_to have_content @users[2].name
    end
  end

  feature 'New Micropost' do
    scenario 'Success' do
      login(@user)
      fill_in 'micropost[content]', with: 'test'
      expect{ click_button '投稿する', match: :first }.to change{ Micropost.count }.by(1)
      expect(page).to have_content '投稿に成功しました'
      expect(page).to have_http_status 200
      expect(page).to have_title full_title("#{@user.name}")
    end

    scenario 'Fail (no content)' do
      login(@user)
      fill_in 'micropost[content]', with: ''
      expect{ click_button '投稿する', match: :first }.to change{ Micropost.count }.by(0)
      expect(page).to have_content '投稿に失敗しました。投稿文が入力されているかご確認ください。'
      expect(page).to have_http_status 200
      expect(page).to have_title full_title("#{@user.name}")
    end
  end

  feature 'Delete Micropost' do
    scenario 'Success' do
      login(@user)
      expect{ click_on 'ゴミ箱のアイコン', match: :first }.to change{ Micropost.count }.by(-1)
      expect(page).to have_content '投稿を削除しました'
      expect(page).to have_http_status 200
      expect(page).to have_title full_title("#{@user.name}")
    end
  end
end
