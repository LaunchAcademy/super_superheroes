CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    AWS_ACCESS_KEY_ID: ENV['AWS_ACCESS_KEY_ID'],
    AWS_SECRET_ACCESS_KEY: ENV['AWS_SECRET_ACCESS_KEY']
  }
  config.fog_directory  = "Superheroes_grp_project"
end
