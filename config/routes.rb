# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'home#index'
  resources :check_points
  resources :machines do
    scope module: :machines do
      resources :actions, only: [:create]
    end
  end

  # TODO: Compact into single endpoint
  mount V1::Events::Attendees => '/api/'
  mount V1::Events::Accesses => '/api/'
  resources :events do
    resources :attendees
    resources :check_records, except: [:show]
    resources :check_points
    resources :staffs, except: [:show]
    resources :accesses, only: [:index]
  end

  # Start tamashii manager
  # TODO: Provide Redis-less mode for Tamashii::Manager
  mount Tamashii::Manager.server => '/tamashii' unless Rails.env.test?
  mount ActionCable.server => '/cable'
end
