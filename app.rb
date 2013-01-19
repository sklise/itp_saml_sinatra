require 'bundler'
Bundler.require

require 'pp'

use Rack::Session::Cookie, key: "ooooooohyeaaaaa"
use OmniAuth::Builder do
  provider :saml,
    :assertion_consumer_service_url => "http://localhost:9393/auth/saml/callback",
    :issuer                         => "ITP Thesis Site",
    :idp_sso_target_url             => "http://itp.nyu.edu/simplesaml/saml2/idp/SSOService.php",
    :idp_cert                       => ENV['IDP_CERT']
end

get '/' do
  "<a href='/auth/saml'>Sign in with NYU</a>"
end

post '/auth/saml/callback' do
  auth = request.env['omniauth.auth']
  pp auth
end