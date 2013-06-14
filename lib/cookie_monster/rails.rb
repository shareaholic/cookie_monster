module CookieMonster
  module Rails
    private

    def cookie_monster
      @cookie_monster ||= CookieMonster::Jar.new(request: request, response: response, expires: 1.day.from_now)
    end
  end
end
