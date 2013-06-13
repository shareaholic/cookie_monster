module CookieMonster
  class Encryption
    def initialize(pass, cipher_type=Type)
      @aes = ::OpenSSL::Cipher::Cipher.new(cipher_type)
      @aes.padding = 1
      #NOTE: a2*32 is for 256bit AES, change to 16 for 128...
      @key = Digest::SHA1.hexdigest(pass).unpack('a2'*32).map{|x|x.hex}.pack('c'*32)
      #@key = Digest::SHA256.digest(pass)
      @password = pass
    end

    def encrypt(data)
      @aes.encrypt
      @aes.key = @key
      @aes.update(data) + @aes.final
    end

    def decrypt(data)
      @aes.decrypt
      @aes.key = @key
      @aes.update(data) + @aes.final
    rescue OpenSSL::Cipher::CipherError
      raise PasswordInvalid, "Password incorrect!"
    end

    class PasswordInvalid < Exception
      def initialize(s); s; end
    end
  end
end
