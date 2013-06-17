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
      @aes.update(json_serialized_payload) + @aes.final
    end

    def decrypt
      @aes.decrypt
      @aes.key = @key
      decrypted = @aes.update(@payload) + @aes.final
      json_parsed_payload decrypted
    rescue OpenSSL::Cipher::CipherError
      raise PasswordInvalid, "Password incorrect!"
    end

    private

    def json_serialized_payload
      if @payload.is_a? String
        @payload
      else
        @payload.to_json
      end
    end

    def json_parsed_payload(payload)
      begin
        parsed = JSON.parse payload
        parsed.with_indifferent_access if parsed.is_a? Hash
      rescue JSON::ParserError
        payload
      end
    end

    class PasswordInvalid < Exception
      def initialize(s); s; end
    end
  end
end
