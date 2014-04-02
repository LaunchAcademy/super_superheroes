require 'spec_helper'

feature 'user edits their profile', %q{
  As an authenticated user
  I want to edit my profile
  So that I can have the correct information
} do

# acceptance criteria
# *I must enter a unique username
# *I must enter a valid unique email
# *I must enter a password
# *I must confirm my password
# *If I do not enter all required information, I receive an error
# *I receive an error message if my username is not unique
# *I receive an error message if I provided an invalid email
# *I receive an error message if my email is not unique
# *I receive an error message if my password does not match up

  scenario 'user can access an edit page' do
    user = FactoryGirl.create(:user)
    sign_in_as user

    visit root_path
    click_on 'Edit Profile'
    expect(page).to have_content('Edit User')
  end
  scenario 'user can change their email'
  scenario 'user can change their password'
end
