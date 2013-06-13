require 'openssl'
require 'cookie_monster/base'
require 'cookie_monster/configuration'
require 'cookie_monster/controller'
require 'cookie_monster/encryption'
require 'cookie_monster/jar'
require 'cookie_monster/version'

module CookieMonster
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end
end
