require 'spec_helper'

feature 'add movie', %Q{

As a user signed in
I want to be able to add a movie
So that everyone can review it

} do

# * I must enter a movie title
# * I must enter a movie year
# * I must enter a superhero name
# * I can optionally enter a mpaa_rating [G, PG, PG-13, R, NC-17]
# * I can optionally enter a synopsis
# * I can optionally enter a director name
# * I must click “add movie” to complete adding movie
# * If I don’t enter required info, I receive an error message
# * if title and year combination is NOT unique, I receive an error message

  scenario 'user adds movie with valid attributes' do
    visit new_movie_path
    fill_in 'Title', with: 'The Dark Knight'
    fill_in 'Year', with: '2008'
    fill_in 'Superhero', with: 'Batman'
    fill_in 'MPAA rating', with: 'PG-13'
    fill_in 'Director', with: 'Christopher Nolan'
    fill_in 'Synopsis', with: "I'm pretty sure this is the one with Heath Ledger"
    click_on 'Add Movie'

    expect(page).to have_content 'The Dark Knight'
  end

  scenario 'user adds movie with invalid attributes' do
    visit new_movie_path
    click_on 'Add Movie'

    expect(page).to have_content 'Movie could not be saved'
    expect(page).to have_content 'Add a Movie'
  end

  scenario 'user adds movie that is already in database' do
    movie = FactoryGirl.create(:movie)
    visit new_movie_path
    fill_in 'Title', with: movie.title
    fill_in 'Year', with: movie.year
    fill_in 'Superhero', with: "Spiderman"

    click_on 'Add Movie'

    expect(page).to have_content 'Movie could not be saved'
    expect(page).to have_content 'Add a Movie'
  end

  scenario 'user adds movie with same title as existing movie' do
    movie = FactoryGirl.create(:movie)
    visit new_movie_path
    fill_in 'Title', with: movie.title
    fill_in 'Year', with: "1998"
    fill_in 'Superhero', with: "Batman"

    click_on 'Add Movie'

    expect(page).to have_content movie.title
  end


end
