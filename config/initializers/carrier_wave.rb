# frozen_string_literal: true

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      # Amazon S3
      provider: 'AWS',
      region: 'ap-northeast-1',
      aws_access_key_id: Rails.application.credentials.s3[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.s3[:secret_access_key]
    }
    config.fog_directory = Rails.application.credentials.s3[:bucket]
  end
end
