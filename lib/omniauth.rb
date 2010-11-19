require 'omniauth/openid'
require 'openid/store/filesystem'

use OmniAuth::Strategies::GoogleApps,
    OpenID::Store::Filesystem.new('/tmp'),
    :name => 'admin',
    :domain => 'tapiocacollective.com'

# login action
get '/login' do
  redirect '/auth/admin'
end

# omniauth callback
post '/auth/:provider/callback' do
  auth = request.env['omniauth.auth']
  session[:email] = auth['user_info']['email']
  redirect session[:return_to] ? session.delete(:return_to) : '/'
end

# logout action
get '/logout' do
  session[:email] = nil
  redirect '/'
end

helpers do

  def authorize!
    session[:return_to] = request.fullpath
    redirect '/login' unless logged_in?
    halt 403, haml('%center You are not authorized to view the requested page') unless authorized?
    session[:return_to] = nil
  end

  def authorized?
    true if logged_in? && authorized_users.include?(current_user)
  end

  def authorized_users
    settings.authorized_users || []
  end

  def current_user
    session[:email]
  end

  def logged_in?
    !!current_user
  end

end

