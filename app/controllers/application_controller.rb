class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Include the AuthenticationHelper
  include AuthenticationHelper

  protected

  def github
    @github ||= Github.new client_id: Jekyllist.client_id, client_secret: Jekyllist.client_secret
  end
end
