module CookieMonster
  class Jar < Base
    def initialize(cookie_object)
      @cookie_object = cookie_object
      @options = configuration.cookies
    end

    def [](key)
      cookie = @cookie_object[key]
      return nil unless cookie

      encrypted = Encryption.new(cookie)
      encrypted.decrypt
    end

    def []=(key, value)
      encrypted_value = Encryption.new(value).encrypt

      @cookie_object[key] = {
        :value => encrypted_value,
        :httponly => @options[:httponly],
        :expires => @options[:expires],
        :domain => @options[:domain],
        :secure => false # Needed so it can be read by cookie logger over http
      }
    end
  end
end
