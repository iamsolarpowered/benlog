# Require gems
%w( rubygems sinatra padrino-helpers erb builder haml sass feed-normalizer ).each {|lib| require lib }

# Require DataMapper
%w( dm-core dm-migrations dm-timestamps ).each {|lib| require lib }

# Require models
Dir.glob('models/*.rb').each {|model| require model }

# Practice safe sessions
use Rack::Session::Pool, :key => '_benlog'

# Config
configure do
  set :root, File.expand_path(File.dirname(__FILE__))
  set :public, "#{settings.root}/public"
  set :authorized_users, %w( ben@tapiocacollective.com )
  DataMapper.setup(:default, "sqlite3://#{settings.root}/db/ben.db")
  DataMapper.auto_upgrade!
end

# Require extensions
require 'lib/partial'
require 'lib/omniauth'

get '/' do
  record_request
  @updates = Update.all(:order => [:published_at.desc])
  haml :index
end

get '/rss' do
  record_request
  @updates = Update.all(:order => [:published_at.desc])
  builder :rss
end

get '/latest_updates.js' do
  content_type 'text/js'
  @updates = Update.latest
  erb :latest_updates
end

get '/style.css' do
  content_type 'text/css'
  response['Expires'] = (Time.now + 60*60*24).httpdate # cache for one day
  sass :style
end

get '/requests' do
  authorize!
  @requests = Request.all(:order => [:created_at.desc])
  haml :requests
end

# Automatically pull changes and restart when Github repo is updated
post '/release' do
  #TODO: Make sure it's really from Github!
  @payload = params[:payload] #TODO: Parse JSON (if needed)
  #TODO: Only do this if master branch was updated
  system 'git pull origin master'
  system 'touch tmp/restart.txt'
  'OK'
end

helpers do
  include Padrino::Helpers

  def record_request
    Request.create_from_env(env)
  end
end

