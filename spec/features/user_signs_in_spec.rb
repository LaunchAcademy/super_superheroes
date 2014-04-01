require 'spec_helper'

feature 'user signs in', %Q{

  As an unauthenticated user
  I want to sign in
  So that I can write a review

} do

# * I must enter my username and password
# * If I don’t enter valid username, I receive an error
# * If my password does not match the username I provided, I receive an error message


  scenario 'user enters correct information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link 'Sign In'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    expect(page).to have_content('Welcome')
    expect(page).to have_content('Sign Out')
  end

  scenario 'user enters incorrect password' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link 'Sign In'
    fill_in 'Username', with: 'algneriuabg'
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    expect(page).to have_content('Invalid username')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'user enters invalid username' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link 'Sign In'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'lasvnwaln'
    click_on 'Sign in'

    expect(page).to have_content('Invalid', 'password')
    expect(page).to_not have_content('Sign Out')
  end

end
