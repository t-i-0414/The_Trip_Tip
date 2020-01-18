# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'StaticPages', type: :feature do
  feature 'should render right home page layouts' do
    background do
      visit root_path
    end
    scenario 'should have the right links' do
      expect(page).to have_link 'The Trip Tipのロゴ', href: root_path
      expect(page).to have_link 'The Trip Tipについて', href: about_path
      expect(page).to have_link '利用規約', href: terms_of_use_path
      expect(page).to have_link 'プライバシーポリシー', href: privacy_path
    end
  end
end
