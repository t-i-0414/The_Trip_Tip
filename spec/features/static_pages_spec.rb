# frozen_string_literal: true

require 'rails_helper'

describe 'Home' do
  specify '画面の表示' do
    visit '/'
    expect(page).to have_title('The Trip Tip')
  end
end

describe 'about' do
  specify '画面の表示' do
    visit '/about'
    expect(page).to have_title('The Trip Tipについて | The Trip Tip')
  end
end

describe 'terms_of_use' do
  specify '画面の表示' do
    visit '/terms_of_use'
    expect(page).to have_title('利用規約 | The Trip Tip')
  end
end

describe 'privacy' do
  specify '画面の表示' do
    visit '/privacy'
    expect(page).to have_title('プライバシーポリシー | The Trip Tip')
  end
end
