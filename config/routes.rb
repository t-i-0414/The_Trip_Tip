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

  resources :user, only: %i[index show]

  authenticated :user do
    root to: 'user#root', as: :user_root
  end

  resources :user do
    member do
      get :following, :followers
    end
  end

  resources :micropost, only: %i[index create show destroy]

  resources :relationships, only: %i[create destroy]

  get '/user/:id/follows_posts', to: 'microposts#timeline', as: :user_timeline

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/terms_of_use', to: 'static_pages#terms_of_use'
  get '/privacy', to: 'static_pages#privacy'

  # exception
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end
