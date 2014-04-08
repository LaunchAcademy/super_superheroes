require 'spec_helper'

feature 'admin deletes a movie', %Q{
  As an admin
  I want to delete a movie if it’s inappropriate
  So that people don’t get offended
  } do

  # Acceptance Criteria
  # * I can navigate to a page to see a list of movies
  # * I can click on a link next to each movie to delete it
  # * When I delete a movie, its reviews and votes are also deleted

  context 'logged in as admin' do
    before :each do
      @admin = FactoryGirl.create(:user, role: 'admin')
      @movies = FactoryGirl.create_list(:movie, 3)
      @review = FactoryGirl.create_list(:review, 3, movie: @movies.first)
      @prev_count = Movie.count
      sign_in_as(@admin)
      visit movies_path
    end

    scenario 'Admin can see list of movies' do
      @movies.each do |movie|
        expect(page).to have_content(movie.title)
      end
    end

    scenario 'Admin delete movie' do

      within(:css, "#movie_#{@movies.first.id}") do
        click_link 'Delete'
      end

      expect(Movie.count).to eq(@prev_count - 1)
      expect(page).to_not have_content(@movies.first.title)
      expect(@movies.first.reviews.count).to eq(0)
    end

  end

  context 'logged in as non-admin user or unauthenticated user' do
    scenario 'visit movies page as non-admin' do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit movies_path

      expect(page).to_not have_content('Delete')
    end
  end

end
