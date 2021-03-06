# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "asin/version"

Gem::Specification.new do |s|
  s.name        = "asin"
  s.version     = ASIN::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Peter Schröder']
  s.email       = ['phoetmail@googlemail.com']
  s.homepage    = 'http://github.com/phoet/asin'
  s.summary     = 'Simple interface to Amazon Item lookup.'
  s.description = 'Amazon Simple INterface or whatever you want to call this.'

  s.rubyforge_project = "asin"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('crack', '~> 0.1.8')
  s.add_dependency('hashie', '~> 1.0.0')
  s.add_dependency('httpi', '~> 0.7.9')
  
  s.add_development_dependency('httpclient', '~> 2.1.6.1')
  s.add_development_dependency('rspec', '~> 2.4.0')
  s.add_development_dependency('fuubar', '~> 0.0.3')
end
