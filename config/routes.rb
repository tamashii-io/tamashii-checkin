# frozen_string_literal: true
Rails.application.routes.draw do
  root 'home#index'
  resources :check_points do
  end
  resources :machines do
  end
end
