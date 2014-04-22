require 'spec_helper'

feature 'User uploads a profile picture', %q{
  As a user signed in
  I want to upload a profile pic
  So that my review is associated with me

} do

  # Acceptance Criteria
  # * I can optionally include a photo for my profile
  # * If I supply a photo, it must be a jpg, png, or gif
  # * If I supply a photo, it cannot exceed 5MB

  scenario 'User uploads valid photo' do
    prev_count = User.count
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in "Username", with: user.username
    fill_in "Email", with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    attach_file 'Profile Picture', Rails.root.join('spec/file_fixtures/bunny.jpeg')

    click_button 'Sign up'

    expect(page).to have_content('Welcome')
    expect(User.count).to eq(prev_count + 1)
    expect(User.last.profile_photo.url).to be_present

  end

  scenario 'User uploads invalid photo' do
    prev_count = User.count
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in "Username", with: user.username
    fill_in "Email", with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    attach_file 'Profile Picture', Rails.root.join('spec/file_fixtures/bunny.txt')

    click_button 'Sign up'
    expect(page).to have_content('Please review the problems below')
    expect(User.count).to eq(prev_count)
  end

end
