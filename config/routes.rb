# frozen_string_literal: true
Rails.application.routes.draw do
  resources :events do
    resources :attendees
  end
end