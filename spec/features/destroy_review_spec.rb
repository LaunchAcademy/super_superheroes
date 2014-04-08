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

  let!(:movie) { FactoryGirl.create(:movie) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:reviews) do
    FactoryGirl.create_list(:review, 3, movie: movie)
    FactoryGirl.create_list(:review, 2, movie: movie, user: user)
  end

  scenario 'signed in user destroys a review' do
    sign_in_as(user)
    visit movie_path(movie)

    within(:css, "#review_#{reviews[0].id}") do
      click_on 'Delete'
    end

    within(:css, '.reviews') do
      page.should have_button('Delete', count: 1)
    end

    expect(page).to have_content 'Review successfully deleted.'
    expect(Review.where(id: reviews[0].id)).to be_empty
    expect(page).to have_content movie.title
  end

  scenario 'Standard user can only see delete links on their own reviews' do
    sign_in_as(user)
    visit movie_path(movie)

    within(:css, '.reviews') do
      page.should have_button('Delete', count: 2)
    end

  end

  scenario 'Unauthorized cannot see any delete links' do
    visit movie_path(movie)

    within(:css, '.reviews') do
      page.should have_button('Delete', count: 0)
    end
  end

end
