require 'spec_helper'

feature 'user edits a review', %Q{

As a user signed in
I want to edit my review
So that I can correct my mistakes
} do

# * I can go to my review and edit it to make changes.
# * I must select a rating that is between 0 to 5.
# * I can optionally enter some text in a review box
# * I receive an error message if I don’t specify a rating
# * I must click ‘update review’ to update my review of the movie

  let!(:review) {FactoryGirl.create(:review)}
  let(:review_count) {Review.count}

  context 'user edits their own review' do
    before :each do
      sign_in_as(review.user)
      visit movie_path(review.movie)
      within(:css, "##{review.id}") do
        click_link 'Edit'
      end
    end

    scenario 'user updates a review with valid attributes' do
      new_rev = FactoryGirl.build(:review, body: 'Meh', movie: review.movie)
      select(new_rev.rating, from: 'Rating')
      fill_in 'Review', with: new_rev.body
      click_on 'Finish Review'

      expect(page).to have_content new_rev.body
      expect(page).to_not have_content review.body
      expect(page).to have_content 'Success!'
      expect(Review.count).to eq(review_count)
      expect(page).to have_content review.movie.title
    end

    scenario 'user updates a review with invalid attributes' do
      select("", from: 'Rating')
      click_on 'Finish Review'
      expect(page).to have_content 'Review could not be saved.'
      expect(page).to have_content 'Edit This Review'
    end
  end

  scenario 'user cannot edit reviews they did not post' do
    sign_in_as(FactoryGirl.create(:user))
    visit movie_path(review.movie)
    within(:css, "##{review.id}") do
      expect(page).to_not have_content 'Edit'
    end
  end

end
