# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'track/version'

Gem::Specification.new do |s|
  s.name        = "track"
  s.version     = Track::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lars Kuhnt"]
  s.email       = ["lars.kuhnt@gmail.com"]
  s.homepage    = "http://github.com/larskuhnt/track"
  s.summary     = "Nano framework to build small server applications based on rack"
  s.description = "Nano framework to build small and fast server applications based on rack"
  
  s.executables = ['track']
  s.default_executable = 'track'
  
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_dependency 'rack'
  s.add_development_dependency "rspec"
  s.add_development_dependency "rack-test"
 
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md CHANGELOG.md ROADMAP.md)
  s.require_path = 'lib'
end
