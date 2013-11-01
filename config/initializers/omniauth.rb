require 'omniauth-openid'
require 'openid'
require 'openid/store/filesystem'
require 'gapps_openid'


# OpenID.fetcher.ca_file = "/absolute/path/to/ssl_cacert.pem"

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
#   provider :open_id,  :name => 'admin',
#                       :identifier => 'https://www.google.com/accounts/o8/site-xrds?hd=mymail.mines.edu',
#                       :store => OpenID::Store::Filesystem.new('/tmp')
# end
Rails.application.config.middleware.use Rack::Session::Cookie
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_apps, 
#            domain: 'mymail.mines.edu'

# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "577255551189.apps.googleusercontent.com", "9Y6EjYFulWutGnNjDXJ3CYkt"
  # {
    # :access_type => 
  # }
end