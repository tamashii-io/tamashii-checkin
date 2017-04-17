# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  layout :pick_layout

  private

  def pick_layout
    return 'session' if %w(new).include?(params[:action])
  end
end
