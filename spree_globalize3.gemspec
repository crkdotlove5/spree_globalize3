# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_globalize3'
  s.version     = '2.0.1'
  s.summary     = 'Spree Globalize3'
  s.description = 'Adding Internlization to Spree'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'saikiran'
  s.email     = 'saikiran.mothe@gmail.com'
  s.email     = 'sai.kiran@partheas.com'
  s.homepage  = 'http://www.partheas.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.0.1'
  s.add_dependency 'globalize3', '~> 0.3.0'
  s.add_dependency 'i18n'
  s.add_dependency 'http_accept_language', '2.0.0.pre'

  s.add_dependency 'i18n_routing', '~> 0.6'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
