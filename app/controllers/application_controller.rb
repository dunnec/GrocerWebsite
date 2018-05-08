class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :devise_config_params, if: :devise_controller?

  protected 
  def devise_config_params
  	devise_parameter_sanitizer.permit(:sign_up, keys:[:fname, :lname, :dob, :email, :password, :remember_me])
  	devise_parameter_sanitizer.permit(:sign_in, keys:[:email, :password, :remember_me])
  	devise_parameter_sanitizer.permit(:account_update, keys:[:fname, :lname, :dob, :email, :password, :remember_me])
  end
end
