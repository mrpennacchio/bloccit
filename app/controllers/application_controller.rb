class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  # we define require_sign_in to redirect un-signed-in users. we define this method in ApplicationController
  def require_sign_in
    unless current_user
      flash[:alert] = "You must be logged in to do that"

      #redirect un-signed-in users to the sign-in page
      redirect_to new_session_path
    end
  end
end
