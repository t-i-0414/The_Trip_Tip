# frozen_string_literal: true

require 'rails_helper'

describe 'Home' do
  specify '画面の表示' do
    visit '/static_pages/home'
    expect(page).to have_title('TheTripTip')
  end
end
