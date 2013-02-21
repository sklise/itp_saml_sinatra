require 'bundler'
Bundler.require

require './app'

rack_app = Rack::Builder.new do
  use Rack::Session::Cookie, key: "ooooooohyeaaaaa"
  use Rack::MethodOverride
  use Rack::Flash, accessorize: [:error, :success]

  use OmniAuth::Builder do
    provider :saml,
      :assertion_consumer_service_url => "http://localhost:9393/auth/saml/callback",
      :issuer                         => "ITP Thesis Site Local",
      :idp_sso_target_url             => "http://itp.nyu.edu/simplesaml/saml2/idp/SSOService.php",
      :idp_cert                       => ENV['IDP_CERT']
  end

  use Warden::Manager do |config|
    config.serialize_into_session{|user| user.netid }
    config.serialize_from_session{|netid| User.first(netid: netid) }
    config.scope_defaults :default,
      strategies: [:omniauth],
      action: 'unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  # Define the strategy for authentication... This is probably not going to be
  # necessary.
  Warden::Strategies.add(:omniauth) do
    def valid?
      params['user']
    end

    def authenticate!
      user = User.first(netid: params['user']['netid'])

      if user.nil?
        fail!("The username you entered does not exist.")
      elsif user.authenticate(params['user']['password'])
        success!(user)
      else
        fail!("Could not log in")
      end
    end
  end

  map ('/') { run SimpleSimpleSAML }
end

run rack_app