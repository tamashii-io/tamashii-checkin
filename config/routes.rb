# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  resources :check_points
  resources :machines
  resources :events do
    resources :attendees
    resources :check_records
  end
end
