# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Static pages', type: :feature do
  feature 'Home page' do
    background do
      visit root_path
    end
    scenario 'should have the right title' do
      expect(page).to have_title full_title('')
    end
  end

  feature 'About page' do
    background do
      visit about_path
    end
    scenario 'should have the right title' do
      expect(page).to have_title full_title('The Trip Tipについて')
    end
  end

  feature 'Terms of use page' do
    background do
      visit terms_of_use_path
    end
    scenario 'should have the right title' do
      expect(page).to have_title full_title('利用規約')
    end
  end

  feature 'Privacy policy page' do
    background do
      visit privacy_path
    end
    scenario 'should have the right title' do
      expect(page).to have_title full_title('プライバシーポリシー')
    end
  end
end
