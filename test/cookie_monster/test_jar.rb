require 'test/unit'
require 'cookie_monster'

class FakeRequest
  def cookies
    { foo: 'a cookie' }
  end
end

class FakeResponse
  attr_reader :cookies
  def initialize
    @cookies = {
      a_cookie: CookieMonster::Encryption.new('already set').encrypt
    }
  end

  def set_cookie key, options
    @cookies[key] = options
  end
end

class JarTest < Test::Unit::TestCase
  def setup
    CookieMonster.configure do |config|
      config.key = 'a key'
      config.iv = 'an iv'
    end
    @options = {
      request: FakeRequest.new,
      response: FakeResponse.new
    }
    @jar = CookieMonster::Jar.new(@options)
  end

  def test_setting_a_cookie
    @jar[:hello] = 'testing a cookie'
    assert_equal CookieMonster::Encryption.new('testing a cookie').encrypt,
      @jar.response.cookies[:hello][:value]
  end

  def test_reading_a_cookie_set_in_response_first
    @jar[:something] = 'setting for the response'
    assert_equal 'setting for the response', @jar[:something]
  end

  def test_reading_a_cookie_from_request
    assert_equal 'already set', @jar[:a_cookie]
  end
end
