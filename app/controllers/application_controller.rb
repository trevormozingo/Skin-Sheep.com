class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def checkSesh
  	if session[:user_id]
  		redirect_to uhome_path
  	end
  end

  def checkLoggedIn
  	if !session[:user_id]
  		redirect_to root_path
  	end
  end


  helper_method :checkSesh
  helper_method :checkLoggedIn
end
