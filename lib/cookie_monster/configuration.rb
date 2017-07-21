require 'securerandom'

module CookieMonster
  class Configuration
    attr_accessor :key, :cipher_type

    def initialize
      @cipher_type = 'AES-256-CBC'
    end

    def iv
      SecureRandom.hex(10)
    end
  end
end
