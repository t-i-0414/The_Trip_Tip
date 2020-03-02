# frozen_string_literal: true

# default class
class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home; end

  def about; end

  def terms_of_use; end

  def privacy; end

  protected

  def logged_in_user
    @user = User.find(current_user.id) if user_signed_in?
  end
end
