# frozen_string_literal: true

class UserController < ApplicationController
  def show
    if user_signed_in?
      @user = User.find(params[:id])
    else
      redirect_to new_user_session_path
    end
    # @posts = Post.all.order(created_at: :desc)
    # @posts = Post.page(params[:page]).per(20)
  end

  def root
    redirect_to user_path(id: current_user.id)
  end
end
