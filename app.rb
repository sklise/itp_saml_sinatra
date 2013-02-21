require 'bundler'
Bundler.require
require 'data_mapper'
require 'dm-sqlite-adapter'

# Set String length, DataMapper's default is 50.
DataMapper::Property::String.length(255)
DataMapper::Property.required(true)
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db.sqlite")

class User
  include DataMapper::Resource

  property :netid, String, key: true
  property :first_name, String
  property :last_name, String
end

DataMapper.finalize

DataMapper.auto_upgrade!

class SimpleSimpleSAML < Sinatra::Base
  require 'pp'

  get '/' do
    "<a href='/auth/saml'>Sign in with NYU</a>"
  end

  post '/auth/saml/callback' do
    saml_hash = request.env['omniauth.auth']['extra']['raw_info'].to_hash

    user = User.first_or_create({
      netid: saml_hash['uid'],
      first_name: saml_hash['givenName'],
      last_name: saml_hash['sn']
    })

    env['warden'].set_user user

    saml_hash.inspect
  end

  post '/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path]
    flash.error = env['warden'].message || "You've gotta log in"
    redirect '/'
  end

  get '/protected' do
    env['warden'].authenticate!
    "You better be a user."
  end

  get '/logout' do
    env['warden'].logout
    flash.success = 'Successfully logged out'
    redirect '/'
  end

  get '/current_user' do
    raise env['warden'].user.inspect
  end
end