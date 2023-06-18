class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(admin adminId))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(admin adminId))
  end

  def after_sign_in_path_for(_resource)
    contents_path
  end

  def after_sign_up_path_for(_resource)
    contents_path
  end
end
