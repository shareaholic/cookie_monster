require 'test_helper'

class EncryptionTest < Test::Unit::TestCase
  def test_encrypt_decrypt
    encrypted = CookieMonster::Encryption.new('payload').encrypt
    decryptor = CookieMonster::Encryption.new(encrypted).decrypt

    assert_equal 'payload', decryptor
  end
end
