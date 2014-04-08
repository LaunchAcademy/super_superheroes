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
      @user = FactoryGirl.create(:user)
      @movie = FactoryGirl.create(:movie)
      @review = FactoryGirl.create(:review, movie: @movie)
      sign_in_as(@user)
      visit movie_path(@movie)
    end

    scenario 'User votes on review' do
      click_on 'Up'

      expect(@review.votes.count).to eq(1)
      expect(page).to have_content('1')
      expect(page).to have_content @movie.title
      expect(page).to have_content "Success!"
    end

    scenario 'User changes their vote' do
      click_on 'Up'
      click_on 'Down'
      expect(@review.votes.count).to eq(1)
      expect(Vote.find_by(user: @user, review: @review).value).to eq('Down')

      expect(page).to have_content('Success!')
      expect(page).to have_content('1')
      expect(page).to have_content('0')
    end
  end

  scenario 'Unauthorized user tries to vote' do
    @movie = FactoryGirl.create(:movie)
    @review = FactoryGirl.create(:review, movie: @movie)
    visit movie_path(@movie)
    expect(page).to_not have_button 'Down'
    expect(page).to_not have_button 'Up'
    expect(page).to have_content 'Up: 0'
  end

end
