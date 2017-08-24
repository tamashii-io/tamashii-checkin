# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :deny_access
  before_action :authenticate_user!


 protected

  def deny_access
   flash[:error] = 'access denied'
   redirect_to action: :index
  end

  protect_from_forgery with: :exception
end