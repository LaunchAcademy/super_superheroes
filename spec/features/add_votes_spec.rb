require 'spec_helper'

feature 'user votes on a review', %Q{
  As a user signed in
  I want to be able to ‘like’ or unlike’ a review
  So that good reviews show up first
  } do


  # Acceptance Criteria
  # * When I vote on a review or change my vote, the number of votes is instantly updated
  # * When I vote on a review or change my vote, the “like” or “dislike” button is highlighted (depending on which one I clicked)
  # * If I have not yet voted on this review, I can click either like or dislike

  context 'User signed in' do
    before :each do
      user = FactoryGirl.create(:user)
      movie = FactoryGirl.create(:movie)
      review = FactoryGirl.create(:review, movie: movie)
      sign_in_as(user)
      visit movie_path(movie)
    end

    scenario 'User votes on review' do
      save_and_open_page
      click_on 'Up'
      expect(review.votes.count).to eq(1)
      within(:css, 'span#up_count') do
        expect(page).to have_content('1')
      end
    end

    scenario 'User changes their vote'
  end
  scenario 'Unauthorized user tries to vote'

end
