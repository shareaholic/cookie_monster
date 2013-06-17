$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'test/unit'
require 'cookie_monster'

CookieMonster.configure do |config|
  config.key = 'a key'
  config.iv = 'an iv'
end
