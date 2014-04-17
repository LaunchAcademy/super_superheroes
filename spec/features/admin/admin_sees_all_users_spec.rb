require 'spec_helper'

feature 'admin manages users', %q{
  As a admin
  I want to see all users
  So that I can monitor user accounts
} do

  # Acceptance Criteria
  # * I can see all users
  # * I can see user’s username, email, and their review count

  let!(:users) {FactoryGirl.create_list(:user, 50)}

  context 'Sign in as admin' do
    before :each do
      @admin = FactoryGirl.create(:user, role: 'admin')
      sign_in_as(@admin)
      visit admin_users_path
    end

    scenario 'admin can see all site users' do
      expect(page).to have_content("Welcome Admin!")

      within(:css, '.users') do
        expect(page).to have_selector('div.row', count: 11)
      end

      click_on 'Next ›'

      within(:css, '.users') do
        expect(page).to have_selector('div.row', count: 11)
      end
    end
  end

  context 'Not Admin' do
    scenario 'Signed in but not admin' do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit admin_users_path

      users.each do |user|
        expect(page).to_not have_content(user.username)
      end

      expect(page).to have_content('Unauthorized access.')
      expect(current_path).to eq(root_path)
    end

    scenario 'Not signed in' do
      visit admin_users_path

      users.each do |user|
        expect(page).to_not have_content(user.username)
      end

      expect(page).to have_content('Please sign in or sign up to continue.')
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
