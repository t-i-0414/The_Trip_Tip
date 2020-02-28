# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Users Registrations', type: :feature do
  before(:each) do
    visit new_user_registration_path
  end

  feature 'Render right contents' do
    scenario 'Before register' do
      form = page.find('form#new_user')
      name_field = form.all('.field')[0]
      email_field = form.all('.field')[1]
      password_field = form.all('.field')[2]
      password_confirmation_field = form.all('.field')[3]
      image_input = form.find('input.hidden#user_image')
      btn_action = form.find('.actions.registration').find('input')
      notifications = page.find('.wrapper_notification')

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー新規登録')
      expect(page).to have_selector 'h1', text: 'ユーザー新規登録'

      twitter = page.find('.sns-link.btn.twitter', text: 'twitterでログイン')
      facebook = page.find('.sns-link.btn.facebook', text: 'Facebookでログイン')

      expect(form[:action]).to eq '/users'
      expect(form[:method]).to eq 'post'
      expect(form).to have_css '.field', count: 4

      expect(name_field.find('label')[:for]).to eq 'user_name'
      expect(name_field.find('input')[:autofocus]).to eq 'autofocus'
      expect(name_field.find('input')[:maxlength]).to eq '32'
      expect(name_field.find('input')[:type]).to eq 'text'
      expect(name_field.find('input')[:name]).to eq 'user[name]'

      expect(email_field.find('label')[:for]).to eq 'user_email'
      expect(email_field.find('input')[:autocomplete]).to eq 'email'
      expect(email_field.find('input')[:type]).to eq 'email'
      expect(email_field.find('input')[:name]).to eq 'user[email]'

      expect(password_field.find('label')[:for]).to eq 'user_password'
      expect(password_field.find('input')[:autocomplete]).to eq 'new-password'
      expect(password_field.find('input')[:placeholder]).to eq '半角英数字6文字以上16文字以内'
      expect(password_field.find('input')[:type]).to eq 'password'
      expect(password_field.find('input')[:name]).to eq 'user[password]'

      expect(password_confirmation_field.find('label')[:for]).to eq 'user_password_confirmation'
      expect(password_confirmation_field.find('input')[:autocomplete]).to eq 'new-password'
      expect(password_confirmation_field.find('input')[:type]).to eq 'password'
      expect(password_confirmation_field.find('input')[:name]).to eq 'user[password_confirmation]'

      expect(form).to have_css 'input.hidden#user_image'
      expect(image_input[:type]).to eq 'text'
      expect(image_input[:value]).to eq '/images/default.png'
      expect(image_input[:name]).to eq 'user[image]'

      expect(btn_action[:type]).to eq 'submit'
      expect(btn_action[:name]).to eq 'commit'

      expect(notifications).to have_link '既にアカウントをお持ちの方はこちら', href: new_user_session_path
      expect(notifications).to have_link 'ユーザー認証メールの再送', href: new_user_confirmation_path
    end
  end

  feature 'New registration' do
    scenario 'Successful registration' do
      user = {
        name: 'test',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password_confirmation]
      click_button 'ユーザー登録', match: :first
      # ユーザー認証メールが遅れるようになったら続きを実装
    end

    scenario 'Failed registration' do
      click_button 'ユーザー登録', match: :first

      expect(page).to have_http_status 200
      expect(page).to have_title full_title('ユーザー新規登録')
      expect(page).to have_selector 'h1', text: 'ユーザー新規登録'

      expect(page.find('div#error_explanation')).to have_content /\d 件のエラーが発生したため ユーザ は保存されませんでした。/
    end
  end
  
  feature 'New Updating' do
    before(:each) do
      FactoryBot.create_list(:user, 10, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
      @user = User.find_by(id: 1)
      @user_auth = User.find_by(id: 2)
      @user_auth.uid = '1111111111111111111'
    end
    
    scenario 'Successful updating' do
      act_as @user do
        
      end
      
      act_as @user_auth do
        
      end
    end
  end
end
