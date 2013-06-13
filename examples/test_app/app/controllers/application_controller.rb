class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    auth_cookie[:something] = 'something'
    render json: auth_cookie[:something]
  end

  private

  def auth_cookie
    @auth_cookie ||= CookieMonster::Jar.new(cookies[:auth_cookie] || {}, domain: root_url, expires: 1.day.from_now)
  end
end
