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
  let!(:movie)  {review.movie}
  let!(:user)   {review.user}
  let!(:user_reviews) {FactoryGirl.create_list(:review, 2, movie: movie, user: user)}

  scenario 'user destroys a review' do
    sign_in_as(user)
    visit movie_path(movie.id)

    within(:css, "#review_#{review.id}") do
      click_on 'Delete'
    end

    within(:css, '.reviews') do
      page.should have_button('Delete', count: 2)
    end

    expect(page).to have_content 'Review successfully deleted.'
    expect(Review.where(id: review.id)).to be_empty
    expect(page).to have_content movie.title
  end

  scenario 'user cannot destroy a review they did not post' do
    sign_in_as(FactoryGirl.create(:user))
    visit movie_path(movie)
    within(:css, "#review_#{review.id}") do
      expect(page).to_not have_content 'Delete'
    end
  end

end
