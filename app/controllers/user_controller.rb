# frozen_string_literal: true

class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @posts = Post.all.order(created_at: :desc)
    # @posts = Post.page(params[:page]).per(20)
  end

  def root
    redirect_to user_path(id: current_user.id)
  end
end
