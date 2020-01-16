# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/terms_of_use', to: 'static_pages#terms_of_use'
  get '/privacy', to: 'static_pages#privacy'
  
    # 例外
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end
