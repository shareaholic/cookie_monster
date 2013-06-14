class ApplicationController < ActionController::Base
  include CookieMonster::Rails
  protect_from_forgery

  def index
    cookie_monster[:encrypted] = 'something'
    cookies[:something_else] = 'something else'
    response.set_cookie 'key', { value: 'something', path: '/' }
    render json: response.cookies
  end

  def reading_test
    render json: cookie_monster[:encrypted]
  end
end
