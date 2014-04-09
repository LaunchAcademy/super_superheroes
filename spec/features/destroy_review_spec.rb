require 'spec_helper'

feature 'user edits a review', %Q{

As a user signed in
I want to delete my review
So it’s no longer available
} do

# * On a particular movie’s page, I see “delete” links only on my own reviews
# * When I delete my review, it no longer shows up on the movie’s page
# * All of the votes associated with that review are also deleted
# * I must be signed in to delete a review
# * I can only delete reviews I wrote

  let!(:review) {FactoryGirl.create(:review)}
  let!(:movie) {review.movie}

  scenario 'user destroys a review' do
    sign_in_as(review.user)
    visit movie_path(movie.id)

    within(:css, "##{review.id}") do
      click_on 'Delete'
    end

    expect(page).to_not have_css "##{review.id}"
    expect(page).to have_content 'Review successfully deleted.'
    expect(Review.where(id: review.id)).to be_empty
    expect(page).to have_content movie.title
  end

end
