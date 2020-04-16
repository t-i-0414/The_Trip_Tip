# frozen_string_literal: true

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.s3[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.s3[:secret_access_key],
      region: 'ap-northeast-1',
    }

    config.fog_directory = 'the-trip-tip'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/the-trip-tip'
  else
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  end
end
