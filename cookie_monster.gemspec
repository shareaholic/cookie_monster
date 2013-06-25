$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'cookie_monster/version'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'cookie_monster'
  s.version     = CookieMonster::VERSION
  s.date        = Date.today
  s.summary     = "A simple gem to encrypt cookies for ruby applications."
  s.description = "A simple gem to encrypt cookies for ruby applications."
  s.authors     = ["Dylan Griffin"]
  s.email       = 'dylan@dylangriff.in'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/shareaholic/cookie_monster'

  current_version = Gem::Version.new(RUBY_VERSION.dup)
  if current_version < Gem::Version.new('1.9.3')
    s.add_dependency "activesupport", "~> 3"
  else
    s.add_dependency "activesupport", '>= 3.0.0'
  end

  s.add_development_dependency 'mocha', '~> 0.14.0'
  s.add_development_dependency 'rake', '~> 10.0.4'
end
