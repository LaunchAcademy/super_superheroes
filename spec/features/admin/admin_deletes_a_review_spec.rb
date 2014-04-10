require 'spec_helper'

feature 'Admin deletes review', %Q{

  As an admin
  I want to delete a review if it’s inappropriate
  So that people don’t get offended
} do

  #Acceptance Criteria
  # * I can see a movie’s reviews
  # * I can click on a link next to each review to delete it
  # * When I delete a review, its votes are also deleted


  let!(:movie) { FactoryGirl.create(:movie) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:reviews) do
    FactoryGirl.create_list(:review, 5, movie: movie)
  end

  context 'as admin' do
    before :each do
      @prev_count = Review.count
      admin = FactoryGirl.create(:user, role: 'admin')
      sign_in_as(admin)
      visit movie_path(movie)
    end

    scenario 'Admin can see all delete links' do
      within(:css, '.reviews') do
        page.should have_button('Delete', count: movie.reviews.count)
      end
    end

    scenario 'Admin can delete a review' do
      within(:css, "#review_#{reviews[0].id}") do
        click_button 'Delete'
      end

      within(:css, '.reviews') do
        page.should have_button('Delete', count: movie.reviews.count)
      end

      expect(Review.count).to eq(@prev_count - 1)
    end
  end

end
