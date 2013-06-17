require 'test_helper'

class CookieMonsterTest < Test::Unit::TestCase
  def test_configuration
    CookieMonster.configure do |config|
      config.key = 'a key'
    end

    assert_equal 'a key', CookieMonster.configuration.key
  end

  def test_default_cipher_type
    assert_equal 'AES-256-CBC', CookieMonster.configuration.cipher_type
  end

  def test_iv_not_the_same
    assert_not_equal CookieMonster.configuration.iv, CookieMonster.configuration.iv
  end
end
