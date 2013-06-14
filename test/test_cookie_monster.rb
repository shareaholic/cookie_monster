require 'test_helper'

class CookieMonsterTest < Test::Unit::TestCase
  def test_configuration
    CookieMonster.configure do |config|
      config.key = 'a key'
      config.iv = 'iv'
    end

    assert_equal 'a key', CookieMonster.configuration.key
    assert_equal 'iv', CookieMonster.configuration.iv
  end

  def test_default_cipher_type
    assert_equal 'AES-256-CBC', CookieMonster.configuration.cipher_type
  end
end
