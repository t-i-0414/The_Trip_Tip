# frozen_string_literal: true

def init_db_test
  ActionMailer::Base.deliveries.clear

  users = FactoryBot.create_list(:user, 10, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
  @user = users[0]

  users_auth = FactoryBot.create_list(:user_auth, 10, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
  @user_auth = users_auth[0]
end
