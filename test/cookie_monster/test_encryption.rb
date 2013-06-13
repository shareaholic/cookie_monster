require 'test/unit'
require 'cookie_monster'

class EncryptionTest < Test::Unit::TestCase
  def setup
    CookieMonster.configure do |config|
      config.key = 'a key'
      config.iv = 'x' * 15
    end
  end

  def test_encrypt_decrypt
    encrypted = CookieMonster::Encryption.new('payload').encrypt
    decryptor = CookieMonster::Encryption.new(encrypted).decrypt

    assert_equal 'payload', decryptor
  end
end
