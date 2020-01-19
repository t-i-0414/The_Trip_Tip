# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Error pages', type: :feature do
  describe 'should render right error pages' do
    scenario 'page transition with statuscode:404' do
      visit '/tasks/404test'

      expect(page).to have_content '404 Not Found'
      expect(page.status_code).to eq 404
    end

    scenario 'page transition with statuscode:500' do
      expect_any_instance_of(StaticPagesController).to receive(:about).and_throw(Exception)
      visit about_path

      expect(page).to have_content '500 Internal Server Error'
      expect(page.status_code).to eq 500
    end
  end
end
