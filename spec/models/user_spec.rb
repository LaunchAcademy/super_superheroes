require 'spec_helper'

describe User do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it {should validate_uniqueness_of(:username)}

  it {should have_valid(:email).when('john.doe@igoogle.com', '123johndoe@igoogle.com')}
  it {should_not have_valid(:email).when('', nil, 'john', 'john@igoogle', 'usercom')}

  it {should have_many(:movies).dependent(:nullify)}
  it {should have_many(:reviews).dependent(:nullify)}

end
