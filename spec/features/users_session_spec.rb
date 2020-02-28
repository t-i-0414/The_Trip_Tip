# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Sessions', type: :feature do
  before(:each) do
    init_db_test
    visit new_user_session_path
  end

  # def extract_confirmation_url(mail)
  #   body = mail.body.encoded
  #   body[%r{https?://[\w!?/\+\-_~=;\.,*&@#$%\(\)\'\[\]]+}]
  # end

  feature 'Render right contents' do
    scenario 'Before login' do
      remember_me_field = page.all('.field')[2]
      notification_field = page.find('.wrapper_notification')

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'

      expect(page).to have_link 'twitterでログイン', href:user_twitter_omniauth_authorize_path
      expect(page).to have_link 'Facebookでログイン', href:user_facebook_omniauth_authorize_path

      expect(remember_me_field).to have_field('次回から自動的にログイン')

      expect(notification_field).to have_link 'パスワードをお忘れですか？', href: new_user_password_path
      expect(notification_field).to have_link 'ロックされたアカウントの解除', href: new_user_unlock_path
    end

    scenario 'After login' do
      login(@user)

      expect(page).to have_http_status 200
      expect(page).to have_title full_title("#{@user.name}")

      info_user = page.find('.info_user')
      info_user_close = info_user.find('.user_detail_close')
      info_user_image = info_user.find('img.image_user')
      follow_user = info_user.all('.wrapper_link')[0]
      follower_user = info_user.all('.wrapper_link')[1]
      post_drawer = page.find('#postDrawer')
      post_input = post_drawer.find('#postInput', visible: false)
      post_open = post_drawer.find('#postOpen')
      post_close = post_drawer.find('#postClose')
      post_content = post_drawer.find('#postContent')

      expect(info_user_close[:for]).to eq 'userDetailInput'
      expect(info_user.find('.title_info')).to have_content 'ログインユーザー'
      expect(info_user_image[:src]).to eq @user.image.url
      expect(info_user.find('.name_user')).to have_content @user.name
      expect(follow_user.find('.title_link')).to have_content 'フォロー'
      # フォローリンク未実装
      expect(follower_user.find('.title_link')).to have_content 'フォロワー'
      # フォロワーリンク未実装

      expect(post_input[:type]).to eq 'checkbox'
      expect(post_open[:for]).to eq 'postInput'
      expect(post_open).to have_selector 'span', text: 'つぶやきを投稿する'
      expect(post_close[:for]).to eq 'postInput'

      expect(post_content.find('.post-close')[:for]).to eq 'postInput'
      expect(post_content).to have_selector 'span', text: 'つぶやきを投稿する'
      # つぶやき投稿用のtextareaについては未実装

      # 投稿一覧の取得については未実装
    end
  end

  feature 'New session' do
    scenario 'Success' do
      login(@user)
      expect(page).to have_title full_title("#{@user.name}")
    end

    scenario 'Fail' do
      fill_in 'user[email]', with: 'failed@example.com'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'

      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'passward'
      click_button 'ログイン'
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
    end
  end

  feature 'User root' do
    scenario 'Do not redirect to root' do
      login(@user)
      visit '/'
      expect(current_path).to eq user_path id: @user.id
    end

    scenario 'Do not post as other user' do
      login(@user)
      visit user_path id: @user.id += 1
      user_drawer = page.find('.user_drawer')
      expect(user_drawer).to have_no_content 'つぶやきを投稿する'
      expect(user_drawer).to have_content 'フォローする'
    end
  end

  feature 'Destroy session' do
    scenario 'Success' do
      login(@user)
      logout
    end
  end
end
