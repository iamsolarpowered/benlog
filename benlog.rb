# Require gems
%w( rubygems sinatra padrino-helpers erb builder haml sass feed-normalizer ).each {|lib| require lib }

# Require DataMapper
%w( dm-core dm-migrations dm-timestamps ).each {|lib| require lib }

# Require models
Dir.glob('models/*.rb').each {|model| require model }

require 'lib/partial'

configure do
  set :root, File.expand_path(File.dirname(__FILE__))
  set :public, "#{settings.root}/public"
  DataMapper.setup(:default, "sqlite3://#{settings.root}/db/ben.db")
  DataMapper.auto_upgrade!
end

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
  @requests = Request.all(:order => [:created_at.desc])
  haml :requests
end

helpers do
  include Padrino::Helpers

  def record_request
    Request.create_from_env(env)
  end
end

