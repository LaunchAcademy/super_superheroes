class NewReviewAdded < ActionMailer::Base
  default from: "from@example.com"

  def receipt(review)
    @review = review

    mail to: review.movie.user.email,
      subject: "Someone posted a review of #{review.movie.title}"
  end
end
