require 'spec_helper'

describe Vote do
  it {should validate_presence_of(:user)}
  it {should validate_presence_of(:review)}

  it {should have_valid(:value).when('Up', 'Down')}
  it {should_not have_valid(:value).when(2, 'something', '', nil)}

  it {should belong_to(:user)}
  it {should belong_to(:review)}
end
