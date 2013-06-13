module CookieMonster
  module Controller
    private

    def auth_cookie
      @auth_cookie ||= CookieMonster::Jar.new(request: request, response: response, expires: 1.day.from_now)
    end
  end
end
