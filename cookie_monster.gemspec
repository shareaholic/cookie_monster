$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'cookie_monster/version'

Gem::Specification.new do |s|
  s.name        = 'cookie_monster'
  s.version     = CookieMonster::VERSION
  s.date        = Date.today
  s.summary     = "A simple gem to encrypt cookies for ruby applications."
  s.description = "A simple gem to encrypt cookies for ruby applications."
  s.authors     = ["Dylan Griffin"]
  s.email       = 'dylan@dylangriff.in'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://dylangriff.in'

  s.add_dependency("activesupport", ">= 3.0.0")
end
