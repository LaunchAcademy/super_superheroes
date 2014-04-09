module ApplicationHelper
  def admin?
    true if user_signed_in? && current_user.role == 'admin'
  end

  def user_vote_on(user, review)
    Vote.find_by(user: user, review: review)
  end

  def user_has_upvoted?(user, review)
    if user_vote_on(user, review).nil? || user_vote_on(user, review).value != "Up"
      false
    else
      true
    end
  end

end
