require File.expand_path('../lib/dribbble/version', __FILE__)

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

  s.required_ruby_version = '>= 2.0.0'
  s.add_runtime_dependency 'rest-client', '~> 1.7'

  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'guard-rspec', '~> 4.3'
  s.add_development_dependency 'guard-spork', '~> 1.5'
  s.add_development_dependency 'sinatra', '~> 1.4'
  s.add_development_dependency 'webmock', '~> 1.17'
  s.add_development_dependency 'factory_girl', '~> 4.0'
  s.add_development_dependency 'faker', '~> 1.3'
end
