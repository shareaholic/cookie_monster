module CookieMonster
  class Encryption < Base
    def initialize(payload)
      @aes = ::OpenSSL::Cipher::Cipher.new(configuration.cipher_type)
      @aes.padding = 1
      @key = Digest::SHA256.digest(configuration.key)
      @payload = payload
    end

    def encrypt
      @aes.encrypt
      @aes.key = @key
      @aes.update(@payload) + @aes.final
    end

    def decrypt
      @aes.decrypt
      @aes.key = @key
      @aes.update(@payload) + @aes.final
    rescue OpenSSL::Cipher::CipherError
      raise PasswordInvalid, "Password incorrect!"
    end

    class PasswordInvalid < Exception
      def initialize(s); s; end
    end
  end
end
