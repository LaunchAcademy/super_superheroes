require 'spec_helper'

feature 'view the page for a single movie', %Q{

  As a user
  I want to see the page for a movie
  So I can write a review for that movie

} do

  let!(:movie) { FactoryGirl.create(:movie) }

  scenario 'visiting a movie page' do
    FactoryGirl.create_list(:review, 3, movie_id: movie.id, rating: rand(5))

    visit movie_path(movie)

    expect(page).to have_content movie.title
    expect(page).to have_content movie.year
    expect(page).to have_content movie.superhero
    expect(page).to have_content movie.mpaa_rating
    expect(page).to have_content movie.director
    expect(page).to have_content movie.synopsis
    expect(page).to have_content movie.average_rating
    expect(page).to have_content 'Add Review'

    movie.reviews.each do |r|
      expect(page).to have_content r.rating
      expect(page).to have_content r.body
    end

  end

end
