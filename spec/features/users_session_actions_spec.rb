# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Session Actions', type: :feature do
  before(:each) do
    users = FactoryBot.build_list(:user, 10, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
    User.insert_all users.map(&:attributes)
    @user = User.find_by(id: 1)
    visit new_user_session_path
  end

  feature 'Should render right contents' do
    scenario 'Before login' do
      twitter = page.find('.sns-link.btn.twitter', text: 'twitterでログイン')
      facebook = page.find('.sns-link.btn.facebook', text: 'Facebookでログイン')
      email_field = page.all('.field')[0]
      email_label = email_field.find('.form-label')
      email_input = email_field.find('#user_email')

      password_field = page.all('.field')[1]
      password_label = password_field.find('.form-label')
      password_input = password_field.find('#user_password')

      remember_me_field = page.all('.field')[2]
      remember_me_label = remember_me_field.find('label')
      remember_me_input_check = remember_me_field.find('#user_remember_me')
      remember_me_input_hidden = remember_me_field.all('input', visible: false)[0]

      submit_field = page.find('.actions.login')
      submit_input = submit_field.find('input')

      notification_field = page.find('.wrapper_notification')

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザーログイン')
      expect(page).to have_selector 'h1', text: 'ログイン'

      expect(twitter[:href]).to eq user_twitter_omniauth_authorize_path
      expect(facebook[:href]).to eq user_facebook_omniauth_authorize_path

      expect(email_field).to have_field('メールアドレス')
      expect(email_label[:for]).to eq 'user_email'
      expect(email_input[:autofocus]).to eq 'autofocus'
      expect(email_input[:autocomplete]).to eq 'email'
      expect(email_input[:name]).to eq 'user[email]'

      expect(password_field).to have_field('パスワード')
      expect(password_label[:for]).to eq 'user_password'
      expect(password_input[:autocomplete]).to eq 'current-password'
      expect(password_input[:placeholder]).to eq '半角英数字6文字以上16文字以内'
      expect(password_input[:type]).to eq 'password'
      expect(password_input[:name]).to eq 'user[password]'

      expect(remember_me_field).to have_field('次回から自動的にログイン')
      expect(remember_me_label[:for]).to eq 'user_remember_me'
      expect(remember_me_input_hidden[:name]).to eq 'user[remember_me]'
      expect(remember_me_input_hidden[:type]).to eq 'hidden'
      expect(remember_me_input_hidden[:value]).to eq '0'
      expect(remember_me_input_check[:type]).to eq 'checkbox'
      expect(remember_me_input_check[:value]).to eq '1'
      expect(remember_me_input_check[:name]).to eq 'user[remember_me]'

      expect(submit_input[:type]).to eq 'submit'
      expect(submit_input[:name]).to eq 'commit'
      expect(submit_input[:value]).to eq 'ログイン'

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
    scenario 'Successful login' do
      login(@user)
      expect(page).to have_content 'ログインしました。'
    end

    scenario 'Failed login' do
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
      expect(current_path).to eq user_path id: 1
    end

    scenario 'Do not post as other user' do
      login(@user)
      visit user_path id: 2
      user_drawer = page.find('.user_drawer')
      expect(user_drawer).to have_no_content 'つぶやきを投稿する'
      expect(user_drawer).to have_content 'フォローする'
    end
  end

  feature 'Destroy session' do
    scenario 'Successful logout' do
      login(@user)
      logout
    end
  end
end
