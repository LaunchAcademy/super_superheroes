class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  def admin?
    true if current_user.role == 'admin'
  end

  def validate_admin
    if !user_signed_in?
      redirect_to new_user_session_path, notice: 'Please sign in or sign up to continue.'
    elsif current_user.role != 'admin'
      redirect_to root_path, alert: 'Unauthorized access.'
    end
  end

end
