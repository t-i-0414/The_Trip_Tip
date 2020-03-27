# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  # before_action :correct_user,   only: :destroy
  
    def create
      user = User.find(params[:followed_id])
      current_user.follow(user)
      redirect_to user
    end
      
    def destroy
      user = Relationship.find(params[:id]).followed
      current_user.unfollow(user)
      redirect_to user
    end
  
  protected
  
  def logged_in_user
    return if user_signed_in?

    flash[:alert] = 'アカウント登録もしくはログインしてください。'
    redirect_to new_user_session_path
  end

  private

  # def correct_user
  #   @micropost = Micropost.find(params[:id])

  #   return if @micropost.user_id == current_user.id

  #   flash[:alert] = 'ログインユーザーではない投稿は削除できません'
  #   redirect_to root_url
  # end
end
