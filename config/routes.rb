# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/terms_of_use', to: 'static_pages#terms_of_use'
  get '/privacy', to: 'static_pages#privacy'

  # exception
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end
