require 'spec_helper'

feature 'view a list of all movies', %Q{

  As a user
  I want to see all the movies
  So I can write a review for a movie

} do

  scenario 'visiting movie index' do
    FactoryGirl.create_list(:movie, 10)
    visit '/movies'

    Movie.first(5).each do |movie|
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.year)
    end

    click_on '2'

    Movie.last(5).each do |movie|
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.year)
    end

  end

end
