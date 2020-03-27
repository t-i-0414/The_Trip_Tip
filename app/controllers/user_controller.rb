# frozen_string_literal: true

class UserController < ApplicationController
  before_action :logged_in_user, only: %i[index show following followers]

  def show
    @user = User.find(params[:id])
    @microposts = Micropost.where(user_id: @user.id).page(params[:page]).per(20)
    @micropost = current_user.microposts.build
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all.page(params[:page]).per(20)
    @micropost = current_user.microposts.build
  end

  def root
    redirect_to user_path(id: current_user.id)
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20)
    @micropost = current_user.microposts.build
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    @micropost = current_user.microposts.build
  end

  protected

  def logged_in_user
    return if user_signed_in?

    flash[:alert] = 'アカウント登録もしくはログインしてください。'
    redirect_to new_user_session_path
  end
end
