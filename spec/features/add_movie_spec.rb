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
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit new_movie_path

    prev_count = Movie.count
    movie = FactoryGirl.build(:movie)
    fill_in 'Title', with: movie.title
    fill_in 'Year', with: movie.year
    fill_in 'Superhero', with: movie.superhero
    fill_in 'MPAA rating', with: movie.mpaa_rating
    fill_in 'Director', with: movie.director
    fill_in 'Synopsis', with: movie.synopsis
    click_on 'Add Movie'

    expect(Movie.last.user).to eq(user)
    expect(page).to have_content 'Success!'
    expect(Movie.count).to eq(prev_count + 1)
  end

  scenario 'user adds movie with invalid attributes' do
    sign_in_as(FactoryGirl.create(:user))
    visit new_movie_path

    click_on 'Add Movie'

    expect(page).to have_content 'Movie could not be saved'
    expect(page).to have_content 'Add a Movie'

    within(:css, ".movie_title") do
      expect(page).to have_content "can't be blank"
    end

    within(:css, '.movie_year') do
      expect(page).to have_content "can't be blank"
    end

    within(:css, '.movie_superhero') do
      expect(page).to have_content "can't be blank"
    end
  end

  scenario 'user adds movie that is already in database' do
    sign_in_as(FactoryGirl.create(:user))
    visit new_movie_path

    movie = FactoryGirl.create(:movie)
    fill_in 'Title', with: movie.title
    fill_in 'Year', with: movie.year
    fill_in 'Superhero', with: "Spiderman"

    click_on 'Add Movie'

    expect(page).to have_content 'Movie could not be saved'
    expect(page).to have_content 'Add a Movie'

    within(:css, '.movie_title') do
      expect(page).to have_content 'has already been taken'
    end
  end

  scenario 'user adds movie with same title as existing movie' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit new_movie_path

    movie = FactoryGirl.create(:movie)
    visit new_movie_path
    fill_in 'Title', with: movie.title
    fill_in 'Year', with: "1998"
    fill_in 'Superhero', with: movie.superhero

    click_on 'Add Movie'

    expect(Movie.last.user).to eq(user)
    expect(page).to have_content 'Success!'
    expect(page).to have_content movie.title
  end

  scenario 'unathorized user cannot add movies' do
    visit new_movie_path

    expect(page).to have_content('You need to be signed in to add a movie.')
    expect(current_path).to eq(new_user_session_path)
  end
end
