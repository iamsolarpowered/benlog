require 'omniauth/openid'
require 'openid/store/filesystem'

use OmniAuth::Builder do
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp')
end

# login action
get '/login' do
  redirect '/auth/google_apps?domain=tapiocacollective.com'
end

# omniauth callback
get '/auth/:provider/callback' do
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
    session[:email] #FIXME: totally insecure - uses cookie with no secret!
  end

  def logged_in?
    !!current_user
  end

end

