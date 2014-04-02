require 'spec_helper'

feature 'user sign in to his acccount', %q{
  As an unauthenticated user
  I want to sign in
  So that I can write a review
} do

  # acceptance criteria
  # *I must enter my username and password
  # *If I don’t enter valid username, I receive an error
  # *If my password does not match the username I provided, I receive an error

  before :each do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
  end

  scenario 'sign in successfully' do
    fill_in 'Email', with: @user.email
    fill_in 'user_password', with: @user.password
    save_and_open_page
    within(:css, '.form-actions') do
      click_on 'Sign in'
    end

    expect(page).to have_content('Welcome!')
  end

  scenario 'invalid email is entered' do
    fill_in 'Email', with: 'john.doe@email'
    fill_in 'user_password', with: @user.password

    within(:css, '.form-actions') do
      click_on 'Sign in'
    end
    expect(page).to have_content('Invalid email')
  end

  scenario 'invalid password is entered' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'abc1234'

    within(:css, '.form-actions') do
      click_on 'Sign in'
    end
    expect(page).to have_content('Forgot your password?')
  end

end
