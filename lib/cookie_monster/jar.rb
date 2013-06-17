module CookieMonster
  class Jar < Base
    attr_reader :request, :response

    def initialize(options)
      @request = options.delete(:request)
      @response = options.delete(:response)
      @options = options
    end

    def [](key)
      key = key.to_s

      if @response.cookies[key]
        cookie = @response.cookies[key]
      elsif @request.cookies[key]
        cookie = @request.cookies[key]
      else
        return nil
      end

      if cookie.is_a? Hash
        cookie = cookie[:value]
      end

      encrypted = Encryption.new(cookie)
      encrypted.decrypt
    end

    def []=(key, value)
      encrypted_value = Encryption.new(value).encrypt

      @response.set_cookie key.to_s, {
        :value => encrypted_value,
        :httponly => @options[:httponly],
        :expires => @options[:expires],
        :domain => @options[:domain],
        :path => @options[:path] || '/',
        :secure => false # Needed so it can be read by cookie logger over http
      }
    end
  end
end
