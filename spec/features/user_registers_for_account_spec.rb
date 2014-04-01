require 'spec_helper'

feature 'user registers for an account', %Q{
  As a new user
  I want to create an account
  So that I can review movies
} do

# * I must enter a unique username
# * I must enter a valid unique email
# * I must enter a password
# * I must confirm my password
# * If I do not enter all required information, I receive an error
# * I receive an error message if my username is not unique
# * I receive an error message if I provided an invalid email
# * I receive an error message if my email is not unique
# * I receive an error message if my password does not match up

  scenario 'user enters valid attributes' do
    visit new_user_registration_path
    click_link 'Sign Up'
    fill_in 'username', with: 'iamauser'
    fill_in 'email', with: 'user@email.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Register'

    expect(page).to have_content 'Welcome!'
    expect(page).to have_content 'Sign Out'

    expect(User.count).to eq(1)
  end

  scenario 'user enters email address already in use' do
    user = FactoryGirl.create(:user)
    visit new_user_registration_path
    click_link 'Sign Up'
    fill_in 'username', with: 'iamauser'
    fill_in 'email', with: user.email
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Register'

    expect(page).to have_content 'already been taken'
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'password confirmation does not match password' do
    visit new_user_registration_path
    click_link 'Sign Up'
    fill_in 'username', with: 'iamauser'
    fill_in 'email', with: 'user@email.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'passw0rd'
    click_button 'Register'

    expect(page).to have_content('review the problems below')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'user enter username already in use' do
    user = FactoryGirl.create(:user)
    visit new_user_registration_path
    click_link 'Sign Up'
    fill_in 'username', with: user.username
    fill_in 'email', with: 'email@mail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Register'

    expect(page).to have_content 'already been taken'
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'user does not enter valid attributes' do
    visit new_user_registration_path
    click_link 'Sign Up'
    click_button 'Register'

    expect(page).to have_content('review the problems below')
    expect(page).to_not have_content('Sign Out')
  end
end
