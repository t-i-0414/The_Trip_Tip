# frozen_string_literal: true

class UserController < ApplicationController
  before_action :logged_in_user, only: %i[index show]

  def show; end

  def index
    @users = User.all
  end

  def root
    redirect_to user_path(id: current_user.id)
  end

  protected

  def logged_in_user
    if user_signed_in?
      @user = User.find(params[:id])
    else
      flash[:alert] = 'アカウント登録もしくはログインしてください。'
      redirect_to new_user_session_path
    end
  end
end
