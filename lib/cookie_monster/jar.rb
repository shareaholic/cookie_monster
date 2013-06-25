module CookieMonster
  class Jar < Base
    attr_reader :cookies

    def initialize(cookies)
      @cookies = cookies
    end

    def [](key)
      if @cookies[key]
        cookie = @cookies[key]
      else
        return nil
      end

      if cookie.is_a? Hash
        cookie = cookie[:value]
      end

      encrypted = Encryption.new(cookie)
      encrypted.decrypt
    end

    def []=(key, value_or_options)
      value, options = value_or_options
      options ||= {}

      encrypted_value = Encryption.new(value).encrypt

      @cookies[key] = {
        :value => encrypted_value,
        :httponly => options[:httponly],
        :expires => options[:expires],
        :domain => options[:domain],
        :path => options[:path] || '/',
        :secure => false # Needed so it can be read by cookie logger over http
      }
    end
  end
end
