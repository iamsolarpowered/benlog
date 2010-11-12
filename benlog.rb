# Gems
%w( rubygems sinatra/base haml sass open-uri feed-normalizer mongo ).each {|lib| require lib }

# Application
class Benlog < Sinatra::Base
  DB = Mongo::Connection.new.db("benlog")

  set :public, File.dirname(__FILE__) + '/public'

  get '/' do
    Feed.update_all
    @updates = Update.all
    haml :index
  end

  get '/style.css' do
    sass :style
  end
end

# Models
%w( feed update ).each {|model| require "models/#{model}" }

