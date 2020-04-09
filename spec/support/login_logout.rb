# frozen_string_literal: true

module LoginMacros
  def login(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン', match: :first
    expect(page).to have_content 'ログインしました。'
  end

  def logout
    click_link 'ログアウト', match: :first
    expect(page).to have_content 'ログアウトしました。'
    expect(page).to have_title full_title('')
  end

  def act_as(user)
    login user
    yield
    logout
  end
end
