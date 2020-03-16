# frozen_string_literal: true

def init_db_test
  ActionMailer::Base.deliveries.clear

  @users = FactoryBot.create_list(:user, 21, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
  @user = @users[0]

  @microposts = Micropost.where(user_id: @user.id)
  @micropost = FactoryBot.build(:micropost, user_id: @user.id)

  @users_auth = FactoryBot.create_list(:user_auth, 15, created_at: Time.current, updated_at: Time.current, confirmed_at: Time.current)
  @user_auth = @users_auth[0]

  @pagenate_count = 20
  @pagenate_maximum = 6
end
