# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static Pages', type: :request do
  describe 'should have 200 http status for each static pages' do
    it 'Home' do
      get root_path
      expect(response).to have_http_status 200
    end
    
    it '' do
      get 
      # expect(page).to have_link 'The Trip Tipのロゴ', href: root_path
      # expect(page).to have_link 'The Trip Tipについて', href: about_path
      # expect(page).to have_link '利用規約', href: terms_of_use_path
      # expect(page).to have_link 'プライバシーポリシー', href: privacy_path
      # expect(page).to have_link 'ユーザー登録', href: new_user_registration_path
    end
  end
end
