class ApplicationController < ActionController::Base
  before_action :devise_perams_permission, if: :devise_controller?
  
  private

  def devise_perams_permission
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end
end
