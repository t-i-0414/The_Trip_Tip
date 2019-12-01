# frozen_string_literal: true

Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/signup'
  get 'static_pages/login'
  get 'static_pages/unlock_user'
  get 'static_pages/rest_password'
  get 'static_pages/about'
  get 'static_pages/terms_of_use'
  get 'static_pages/privacy'
  get 'static_pages/error_404'
  get 'static_pages/error_500'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#hello'
end
