require 'omniauth-openid'
require 'openid'
require 'openid/store/filesystem'
require 'gapps_openid'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use Rack::Session::Cookie

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "577255551189.apps.googleusercontent.com", "9Y6EjYFulWutGnNjDXJ3CYkt"
  provider :developer unless Rails.env.production?
end
