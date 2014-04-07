require 'spec_helper'

feature 'add review', %Q{

As a user signed in
I want to add a review
So that other people can read my review

} do
# I must select a movie to review
# I must select a rating that is between 0 to 5.
# I can optionally enter some text in a review box
# I receive an error message if I don’t specify a rating
# I must click ‘finish review’ to complete reviewing the movie

  let!(:movie) { FactoryGirl.create(:movie) }
  let!(:review) { FactoryGirl.build(:review)}
  let!(:review_count) { movie.reviews.count }

  before :each do
    visit movie_path(movie)
    click_link 'Add Review'
  end

  scenario 'user adds a review' do
    select(review.rating, from: 'Rating')
    fill_in 'Review', with: review.body
    click_on 'Finish Review'

    expect(page).to have_content 'Success!'
    expect(page).to have_content review.body
    expect(movie.reviews.count).to eq(review_count + 1)
  end

  scenario 'user adds a review with no text' do
    select(review.rating, from: 'Rating')
    click_on 'Finish Review'

    expect(page).to have_content 'Success!'
    expect(movie.reviews.count).to eq(review_count + 1)
  end


  scenario 'user adds a review with no score' do
    fill_in 'Review', with: review.body
    click_on 'Finish Review'

    expect(page).to have_content 'Review could not be saved.'
    expect(movie.reviews.count).to eq(review_count)
  end
end
