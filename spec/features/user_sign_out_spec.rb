require 'spec_helper'

feature 'user signs out', %q{
  As a user
  I want to be able to sign out
  So that my information is not accessible when offline
} do

  # Acceptance Criteria
  # * Sign out link that ends session
  # * Link is not accessbile to unauthorized users

  scenario 'user signs out successfully' do
    sign_in_as(FactoryGirl.create(:user))

    click_on 'Sign Out'

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Signed out successfully.')
  end

  scenario 'link is not present when not logged in' do
    visit root_path

    expect(page).to_not have_content('Sign Out')
  end

end
