module CookieMonster
  class Configuration
    attr_accessor :key, :cipher_type

    def initialize
      @cipher_type = 'AES-256-CBC'
    end

    def iv
      rand.to_s
    end
  end
end
