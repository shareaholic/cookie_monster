module CookieMonster
  module Rails
    private

    def cookie_monster
      @cookie_monster ||= CookieMonster::Jar.new(cookies)
    end
  end
end
