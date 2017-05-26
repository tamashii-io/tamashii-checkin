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

  mount V1::Events::Attendees => '/api/'
  resources :events do
    resources :attendees
    resources :check_records, except: [:show]
    resources :check_points
    resources :staffs, except: [:show]
  end

  # Start tamashii manager
  mount Tamashii::Manager.server => '/tamashii'
  mount ActionCable.server => '/cable'
end
