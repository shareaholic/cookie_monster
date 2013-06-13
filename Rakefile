begin
  require 'bundler/setup'
  require 'bundler/gem_tasks'
rescue LoadError
  raise 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/test_**.rb'
end

task :default => :test
