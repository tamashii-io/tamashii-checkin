# frozen_string_literal: true
Rails.application.routes.draw do
  root 'home#index'
  resources :check_records do
  end
end
