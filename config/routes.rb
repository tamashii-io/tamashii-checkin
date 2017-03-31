# frozen_string_literal: true
Rails.application.routes.draw do
  root 'home#index'
  resources :events do
    resources :attendees
  end
  resources :check_points 
  resources :machines 
end
