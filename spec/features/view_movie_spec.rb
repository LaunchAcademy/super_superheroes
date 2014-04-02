require 'spec_helper'

feature 'view the page for a single movie', %Q{

  As a user
  I want to see all the movies
  So I can write a review for a movie

} do

  scenario 'visiting movie index' do
    FactoryGirl.create_list(:movie, 3)
    visit '/movies'

    Movie.all.each do |movie|
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.year)
    end

  end

end
