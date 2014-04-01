require 'spec_helper'

describe Movie do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:year)}
  it { should validate_presence_of(:superhero)}

  it { should have_valid(:year).when("2008", "1997")}
  it { should_not have_valid(:year).when("97", "", nil)}

  it { should have_valid(:mpaa_rating).when("", nil, "R")}
  it { should_not have_valid(:mpaa_rating).when("peegee")}
end
