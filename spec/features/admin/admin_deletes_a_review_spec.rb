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


  let(:movie) { FactoryGirl.create(:movie) }
  let(:user) { FactoryGirl.create(:user) }
  let(:reviews) do
    FactoryGirl.create_list(:review, 3, movie: movie)
    FactoryGirl.create_list(:review, 2, movie: movie, user: user)
  end

  context 'as admin' do
    before :each do
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
      reviews
      save_and_open_page
    end
  end

  scenario 'Standard user can only see delete links on their own reviews'

  scenario 'Unauthorized cannot see any delete links'
end
