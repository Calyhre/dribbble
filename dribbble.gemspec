# frozen_string_literal: true

require File.expand_path('lib/dribbble/version', __dir__)

Gem::Specification.new do |s|
  s.name         = 'dribbble'
  s.version      = Dribbble::VERSION
  s.summary      = 'Dribbble API ruby wrapper'
  s.description  = 'Simple gem to make shots and list stuff from Dribbble'
  s.authors      = ['Calyhre']
  s.email        = ['contact@calyh.re']
  s.require_path = 'lib'
  s.homepage     = 'http://github.com/Calyhre/dribbble'
  s.license      = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.required_ruby_version = ['>= 2.5.0', '< 4.0']
  s.add_runtime_dependency 'rest-client', '~> 2.0'

  s.add_development_dependency 'guard-rspec', '~> 4.7'
  s.add_development_dependency 'rake', '~> 12.3.3'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'sinatra', '~> 2.1'
  s.add_development_dependency 'webmock', '~> 3.13'
end
