# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  unless Rails.env.development?
    rescue_from Exception,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def render_404
    @user = User.find(current_user.id) if user_signed_in?
    render 'error/404', status: :not_found
  end

  def render_500
    @user = User.find(current_user.id) if user_signed_in?
    render 'error/500', status: :internal_server_error
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image])
  end

  def after_update_path_for(_resource)
    user_path(id: current_user.id)
  end

  def after_inactive_sign_up_path_for(_resource)
    user_path(id: resource.id)
  end

  def after_sign_in_path_for(_resource)
    user_path(id: current_user.id)
  end

  def after_sign_out_path_for(_resource)
    root_path
  end
end
