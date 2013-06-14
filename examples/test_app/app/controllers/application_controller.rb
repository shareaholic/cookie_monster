class ApplicationController < ActionController::Base
  include CookieMonster::Controller
  protect_from_forgery

  def index
    auth_cookie[:encrypted] = 'something'
    cookies[:something_else] = 'something else'
    response.set_cookie 'key', { value: 'something', path: '/' }
    render json: response.cookies
  end
end
