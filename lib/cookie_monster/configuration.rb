module CookieMonster
  class Configuration
    attr_accessor :key, :iv, :cipher_type

    def initialize
      @cipher_type = 'AES-256-CBC'
    end
  end
end
