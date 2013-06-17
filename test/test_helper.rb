$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'test/unit'
require 'mocha/setup'
require 'cookie_monster'

CookieMonster.configure do |config|
  config.key = 'a key'
end
