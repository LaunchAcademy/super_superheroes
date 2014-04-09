require 'spec_helper'

feature 'admin deletes users', %q{
  As a admin
  I want to delete a user
  So that I can protect the site from trolls
} do

  # * From the list of users I can click on the link to delete the user.
  # * If a user is deleted, it’s reviews and votes are also deleted

  let!(:users) { FactoryGirl.create_list(:user, 10) }

  scenario 'admin deletes a user' do
    sign_in_as(FactoryGirl.create(:user, role: 'admin'))
    prev_count = User.count
    visit admin_users_path

    within(:css, "#user_#{users[0].id}") do
      click_link 'Delete'
    end

    expect(User.count).to eq(prev_count - 1)
    expect(page).to_not have_content(users[0].email)
    expect(page).to have_content('User successfully deleted.')
  end

end
