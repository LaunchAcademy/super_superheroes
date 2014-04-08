module ApplicationHelper
  def admin?
    true if user_signed_in? && current_user.role == 'admin'
  end
end
