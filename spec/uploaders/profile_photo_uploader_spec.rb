require 'spec_helper'
require 'carrierwave/test/matchers'

describe 'ProfilePhotoUploader' do
  include CarrierWave::Test::Matchers

  let(:uploader) do
    ProfilePhotoUploader.new(FactoryGirl.build(:user), :profile_photo)
  end

  let(:path) do
    Rails.root.join('spec/file_fixtures/bunny.jpeg')
  end

  before do
    ProfilePhotoUploader.enable_processing = true
  end

  after do
    ProfilePhotoUploader.enable_processing = false
  end

  it 'stores without error' do
    expect(lambda { uploader.store!(File.open(path))}).to_not raise_error
  end
end
