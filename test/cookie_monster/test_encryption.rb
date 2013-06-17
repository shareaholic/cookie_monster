require 'test_helper'

class EncryptionTest < Test::Unit::TestCase
  def test_encrypt_decrypt
    encrypted = CookieMonster::Encryption.new('payload').encrypt
    decryptor = CookieMonster::Encryption.new(encrypted).decrypt

    assert_equal 'payload', decryptor
  end

  def test_more_complicated_data_types
    payload = { a: 'this is a hash' }.with_indifferent_access
    encrypted = CookieMonster::Encryption.new(payload).encrypt
    decryptor = CookieMonster::Encryption.new(encrypted).decrypt

    assert_equal payload, decryptor
  end
end
