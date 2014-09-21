require 'omniauth-openid'
require 'openid'
require 'openid/store/filesystem'
require 'gapps_openid'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use Rack::Session::Cookie

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
  provider :developer unless Rails.env.production?
end
