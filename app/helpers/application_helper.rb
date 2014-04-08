module ApplicationHelper
  def admin?

    true if user_signed_in? && current_user.role == 'admin'
    # if !user_signed_in?
    #   redirect_to new_user_session_path, alert: 'Please sign in or sign up to continue.'
    # elsif !(current_user.role == 'admin')
    #   redirect_to root_path, alert: 'Unauthorized access.'
    # end
  end
end
