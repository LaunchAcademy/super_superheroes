require 'spec_helper'

feature 'admin sees all site users', %q{
  As a admin
  I want to see all users
  So that I can manage user accounts
} do

  # Acceptance Criteria
  # can go to an admin only page to see all users
  # I can see user’s username, email, and their review count

  scenario 'Admin has access to user list' do
    users = []
    10.times do
      users << FactoryGirl.create(:users)
    end

    admin = FactoryGirl.create(:users, admin: true)
    sign_in_as(admin)
    visit 'admin/users'
    expect(page).to have_content("Welcome Admin!")

    users.each do |user|
      expect(page).to have_content(user.username)
    end
  end



  scenario 'Non-admin cannot go to that page'

  scenario 'Standard user cannot access that page'

end
