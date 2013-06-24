module CookieMonster
  class Jar < Base
    attr_reader :request, :response

    def initialize(options)
      @request = options.delete(:request)
      @response = options.delete(:response)
      @options = options
    end

    def [](key)
      response_cookies = @response.respond_to?(:cookies) ? @response.cookies.with_indifferent_access : {}
      request_cookies = @request.respond_to?(:cookies) ? @request.cookies.with_indifferent_access : {}

      if response_cookies[key]
        cookie = response_cookies[key]
      elsif request_cookies[key]
        cookie = request_cookies[key]
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

      @response.set_cookie key, {
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
