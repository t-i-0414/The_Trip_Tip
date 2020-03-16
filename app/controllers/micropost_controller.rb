# frozen_string_literal: true

class MicropostController < ApplicationController
  before_action :logged_in_user, only: %i[timeline create new show destroy]

  def index
    @microposts = Micropost.all.page(params[:page]).per(20)
  end

  def timeline; end

  def create; end

  def new; end

  def show
    @user = User.find(Micropost.find(params[:id]).user_id)
    @micropost = Micropost.find(params[:id])
  end

  def destroy; end
end
