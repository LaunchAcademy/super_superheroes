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

    click_link 'Sign out'

    expect(page).to have_content('Sign up')
    expect(page).to have_content('Sign in')
    expect(page).to_not have_content('Sign out')
    expect(current_user).to be_nil
  end

  scenario 'link is not present when not logged in'

end
