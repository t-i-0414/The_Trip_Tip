# frozen_string_literal: true

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      # Amazon S3
      provider: 'AWS',
      region: 'ap-northeast-1',
      aws_access_key_id: ENV.fetch('ACCESS_KEY_ID_S3'),
      aws_secret_access_key: ENV.fetch('SECRET_ACCESS_KEY_S3')
    }
    config.fog_directory = ENV.fetch('BUCKET_S3')
  end
end
