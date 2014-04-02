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
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in_as @user
  end

  scenario 'user can access an edit page' do
    click_on 'Edit Profile'
    expect(page).to have_content('Edit User')
  end

  scenario 'user can change their email' do
    click_on 'Edit Profile'
    fill_in 'Email', with: 'superduper@e.com'
    fill_in 'Current password', with: @user.password
    click_on 'Update'

    expect(User.where(username: @user.username).take.email).to eq('superduper@e.com')
    expect(page).to have_content('You updated your account successfully.')
  end

  scenario 'user can change their password' do
    click_on 'Edit Profile'
    fill_in 'Password', with: 'password2'
    fill_in 'Password confirmation', with: 'password2'
    fill_in 'Current password', with: @user.password
    click_on 'Update'

    expect(page).to have_content('You updated your account successfully.')
  end
end
