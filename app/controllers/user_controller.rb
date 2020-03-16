# frozen_string_literal: true

class UserController < ApplicationController
  before_action :logged_in_user, only: %i[index show]

  def show
    @user = User.find(params[:id])
    @microposts = Micropost.where(user_id: @user.id).page(params[:page]).per(20)
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all.page(params[:page]).per(20)
  end

  def root
    redirect_to user_path(id: current_user.id)
  end
end
