require 'spec_helper'

feature 'user registers for a new account', %q{
  As a new user
  I want to create an account
  So that I can review movies
} do

  # acceptance criteria
  # * I must enter a unique username
  # * I must enter a valid unique email
  # * I must enter a password
  # * I must confirm my password
  # * If I do not enter all required information, I receive an error
  # * I receive an error message if my username is not unique
  # * I receive an error message if I provided an invalid email
  # * I receive an error message if my email is not unique
  # * I receive an error message if my password does not match up

  scenario 'provides valid attributes' do
    prev_count = User.count
    user = FactoryGirl.build(:user)
    visit root_path
    click_on 'Sign up'
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password

    within('form') do
      click_on 'Sign up'
    end

    expect(page).to have_content('Welcome')
    expect(User.count).to eq(prev_count + 1)
  end

  scenario 'does not provide all required attributes' do
    visit new_user_registration_path

    within('form') do
      click_on 'Sign up'
    end

    within(:css, "#user_username + .error") do #looking for the next thing
      expect(page).to have_content("can't be blank")
    end

    within(:css, "#user_email + .error") do
      expect(page).to have_content("can't be blank")
    end

    within(:css, "#user_password + .error") do
      expect(page).to have_content("can't be blank")
    end
  end

  scenario 'enters username that is already in use' do
    user_one = FactoryGirl.create(:user)
    user_two = FactoryGirl.build(:user, username: user_one.username)
    visit new_user_registration_path
    fill_in 'Username', with: user_two.username
    fill_in 'Email', with: user_two.email
    fill_in 'user_password', with: user_two.password
    fill_in 'user_password_confirmation', with: user_two.password

    within('form') do
      click_on 'Sign up'
    end
    within(:css, '#user_username + .error') do
      expect(page).to have_content "has already been taken"
    end
  end

  scenario 'password confirmation does not match password' do
    user = FactoryGirl.build(:user, password_confirmation: 'abc12345xyz')
    visit new_user_registration_path
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password_confirmation

    within('form') do
      click_on 'Sign up'
    end

    within(:css, '#user_password_confirmation + .error') do
      expect(page).to have_content("doesn't match Password")
    end
  end

  scenario 'Email is invalid' do
    user = FactoryGirl.build(:user, email: 'john.doe@email')
    visit new_user_registration_path
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password_confirmation

    within('form') do
      click_on 'Sign up'
    end

    within(:css, '#user_email + .error') do
      expect(page).to have_content('is invalid')
    end
  end

  scenario 'Email is not unique' do
    user_one = FactoryGirl.create(:user)
    user_two = FactoryGirl.build(:user, email: user_one.email)
    visit new_user_registration_path
    fill_in 'Username', with: user_two.username
    fill_in 'Email', with: user_two.email
    fill_in 'user_password', with: user_two.password
    fill_in 'user_password_confirmation', with: user_two.password

    within('form') do
      click_on 'Sign up'
    end

    within(:css, '#user_email + .error') do
      expect(page).to have_content "has already been taken"
    end
  end

end
