class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :configure_permitted_parameters, if: :devise_controller?
 
 
  def record_not_found
    flash[:error] = 'Invalid search operation occurred!!'
    redirect_to(request.referrer || root_path)
  end 
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type,:name])
  end
  
  private
  def user_not_authorized
    flash[:alert]="Access denied"
    redirect_to (request.referrer || root_path)
  end  


end
