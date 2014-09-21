require 'securerandom'

task "setup" => ['db:migrate', 'db:seed'] do
  if File.exists? '.env' then
    abort '.env already created.'
  end

  print 'Enter Google client ID: '
  client_id = STDIN.gets.strip
  print 'Enter Google client secret: '
  client_secret = STDIN.gets.strip
  cookie_secret = SecureRandom.hex 64

  File.open('.env', 'w') do |f|
    f.write(<<CONTENTS)
GOOGLE_CLIENT_ID=#{client_id}
GOOGLE_CLIENT_SECRET=#{client_secret}
COOKIE_SECRET_TOKEN=#{cookie_secret}
CONTENTS
  end
end
