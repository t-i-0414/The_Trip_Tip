# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Registrations', type: :feature do
  before :each do
    init_db_test
  end

  feature 'Render right contents' do
    scenario 'Registration page' do
      visit new_user_registration_path


      form = page.find('form#new_user')
      image_input = form.find('input.hidden#user_image')
      notifications = page.find('.wrapper_notification')

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー新規登録')
      expect(page).to have_selector 'h1', text: 'ユーザー新規登録'

      expect(page).to have_link 'twitterでログイン', href:user_twitter_omniauth_authorize_path
      expect(page).to have_link 'Facebookでログイン', href:user_facebook_omniauth_authorize_path

      expect(form).to have_css 'input.hidden#user_image'
      expect(image_input[:type]).to eq 'text'
      expect(image_input[:value]).to eq '/images/default.png'
      expect(image_input[:name]).to eq 'user[image]'

      expect(notifications).to have_link '既にアカウントをお持ちの方はこちら', href: new_user_session_path
      expect(notifications).to have_link 'ユーザー認証メールの再送', href: new_user_confirmation_path
    end

    scenario 'Update page' do
      act_as @user do
        visit edit_user_registration_path
        expect(page).to have_http_status 200
        expect(page).to have_title full_title( 'ユーザー情報編集' )
        expect(page).to have_selector 'h1', text: 'ユーザー情報の設定'
        image_user = page.find('.info_user').find('.image_user')
        expect(image_user[:src]).to eq @user.image.url
      end
    end
  end

  feature 'New registration' do
    before do
      visit new_user_registration_path
    end

    scenario 'Success' do
      records_count = User.count
      user = {
        name: 'test',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      fill_in 'user[name]', with: user[:name]
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password_confirmation]
      click_button 'ユーザー登録', match: :first
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

      confirmation_email

      expect(User.count).to eq records_count+1
      expect(page).to have_content 'ログイン'
    end

    scenario 'Fail' do
      click_button 'ユーザー登録', match: :first

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー新規登録')
      expect(page).to have_selector 'h1', text: 'ユーザー新規登録'

      expect(page.find('div#error_explanation')).to have_content /\d 件のエラーが発生したため ユーザ は保存されませんでした。/
    end
  end

  feature 'New Updating' do
    before do
      @edit = {
        name: 'edit',
        email: 'edit@example.com',
        password: 'editpassword',
        password_confirmation: 'editpassword'
      }
    end

    scenario 'Success' do
      login(@user)
      visit edit_user_registration_path
      fill_in 'user[name]', with: @edit[:name]
      fill_in 'user[password]', with: @edit[:password]
      fill_in 'user[password_confirmation]', with: @edit[:password_confirmation]
      fill_in 'user[current_password]', with: 'password'
      click_button '更   新', match: :first
      expect(page).to have_content 'アカウント情報を変更しました。'
      expect(page).to have_title full_title( @edit[:name] )

      visit edit_user_registration_path
      fill_in 'user[email]', with: @edit[:email]
      fill_in 'user[current_password]', with: @edit[:password]
      click_button '更   新', match: :first
      expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'
      expect(page).to have_title full_title( @edit[:name] )

      confirmation_email

      expect(page).to have_content 'メールアドレスが確認できました。'
      expect(page).to have_title full_title( 'ユーザーログイン' )
      fill_in 'user[email]', with: @edit[:email]
      fill_in 'user[password]', with: @edit[:password]
      click_button 'ログイン', match: :first
      expect(page).to have_content 'ログインしました。'
    end

    scenario 'Success(uid)' do
      act_as @user_auth do
        visit edit_user_registration_path
        fill_in 'user[name]', with: @edit[:name]
        click_button '更   新', match: :first
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_title full_title( @edit[:name] )
      end
    end

    scenario 'Fail' do
      act_as @user do
        visit edit_user_registration_path
        fill_in 'user[current_password]', with: 'passward'
        click_button '更   新', match: :first
        expect(page).to have_content /\d 件のエラーが発生したため ユーザ は保存されませんでした。/
        expect(page).to have_title full_title( 'ユーザー情報編集' )
      end
    end

    scenario 'Delete user' do
      login(@user)
      visit edit_user_registration_path
      records_count = User.count
      click_on 'アカウント削除'
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      expect(page).to have_title 'The Trip Tip'
      expect(User.count).to eq records_count-1

      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン', match: :first
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      expect(page).to have_title 'ユーザーログイン'
    end
  end
end
