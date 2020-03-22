# frozen_string_literal: true

class MicropostController < ApplicationController
  before_action :logged_in_user, only: %i[timeline create new show destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.all.page(params[:page]).per(20)
  end

  def timeline; end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = '投稿に成功しました'
      redirect_to root_url
    else
      flash[:alert] = '投稿に失敗しました。投稿文が入力されているかご確認ください。'
      redirect_to user_url current_user
    end
  end

  def new; end

  def show
    @user = User.find(Micropost.find(params[:id]).user_id)
    @micropost = Micropost.find(params[:id])
  end

  def destroy
    @micropost.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to request.referer || root_url
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
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
