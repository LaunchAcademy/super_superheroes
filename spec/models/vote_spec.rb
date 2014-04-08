require 'spec_helper'

describe Vote do
  it {should have_valid(:user_id).when(FactoryGirl.create(:user).id)}
  it {should_not have_valid(:user_id).when('', nil)}
  it {should have_valid(:review_id).when(FactoryGirl.create(:review).id)}
  it {should_not have_valid(:review_id).when('', nil)}
  it {should have_valid(:value).when('Up', 'Down')}
  it {should_not have_valid(:value).when(2, 'something', '', nil)}
  it {should belong_to(:user)}
  it {should belong_to(:review)}
end
