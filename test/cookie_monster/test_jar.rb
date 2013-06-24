require 'test_helper'

class FakeRequest
  def cookies
    { foo: 'a cookie' }
  end
end

class FakeResponse
  attr_reader :cookies
  def initialize
    @cookies = {
      'a_cookie' => CookieMonster::Encryption.new('already set').encrypt
    }
  end

  def set_cookie key, options
    @cookies[key] = options
  end
end

class JarTest < Test::Unit::TestCase
  def setup
    @options = {
      request: FakeRequest.new,
      response: FakeResponse.new
    }
    @jar = CookieMonster::Jar.new(@options)
  end

  def test_setting_a_cookie
    CookieMonster.configuration.expects(:iv).at_least_once.returns('x' * 16)
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

  def test_indifferent_access
    assert_equal @jar[:a_cookie], @jar['a_cookie']
  end

  def test_setting_a_more_complicated_data_type
    hash = { a: 'this is a hash' }.with_indifferent_access
    @jar[:something] = hash
    assert_equal hash, @jar[:something]
  end

  def test_including_other_options
    @jar[:cookie] = 'something', { expires: 'some point in the future' }
    assert_equal 'some point in the future', @jar.response.cookies[:cookie][:expires]
  end
end
