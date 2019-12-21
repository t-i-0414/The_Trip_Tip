# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', to: 'static_pages#signup'
  get '/login', to: 'static_pages#login'
  get '/unlock_user', to: 'static_pages#unlock_user'
  get '/reset_password', to: 'static_pages#reset_password'
  get '/about', to: 'static_pages#about'
  get '/terms_of_use', to: 'static_pages#terms_of_use'
  get '/privacy', to: 'static_pages#privacy'
end
