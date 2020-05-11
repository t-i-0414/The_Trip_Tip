# frozen_string_literal: true

class MicropostController < ApplicationController
  before_action :logged_in_user, only: %i[timeline create show destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.all.page(params[:page]).per(20)
  end

  def timeline
    @user = User.find(params[:id])

    relationships = Relationship.where(follower_id: params[:id])
    users = relationships.map do |relationship|
      User.find(relationship.followed_id)
    end
    users << @user

    microposts_id = []
    users.each do |user|
      user_microposts = Micropost.where(user_id: user.id)
      user_microposts.each do |micropost|
        microposts_id << micropost.id
      end
    end

    @microposts = Micropost.where(id: microposts_id).page(params[:page]).per(20)
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = '投稿に成功しました'
      redirect_to root_url
    else
      flash[:alert] = if @micropost.content.empty?
        '投稿に失敗しました。投稿文が入力されていません。'
      elsif @micropost.content.length > 140
        '投稿に失敗しました。投稿文は140文字以内で入力してください。'
      else
        '投稿に失敗しました。'
      end
      redirect_to user_url current_user
    end
  end

  def show
    @user = User.find(Micropost.find(params[:id]).user_id)
    @micropost = Micropost.find(params[:id])
  end

  def destroy
    @micropost.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to root_url
  end

  protected
    def logged_in_user
      return if user_signed_in?

      flash[:alert] = 'アカウント登録もしくはログインしてください。'
      redirect_to new_user_session_path
    end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = Micropost.find(params[:id])

      return if @micropost.user_id == current_user.id

      flash[:alert] = 'ログインユーザーではない投稿は削除できません'
      redirect_to root_url
    end
end
