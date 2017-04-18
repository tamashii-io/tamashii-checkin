# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'home#index'
  resources :check_records
  resources :check_points
  resources :machines do
    scope module: :machines do
      resources :actions, only: [:create]
    end
  end
  resources :events do
    resources :attendees
  end

  # Start tamashii manager
  mount Tamashii::Manager::Server => '/tamashii'
  mount ActionCable.server => '/cable'
end
