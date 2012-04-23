require File.expand_path('../lib/uk_phone_numbers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'uk_phone_numbers'
  gem.version = UKPhoneNumbers::VERSION.dup
  gem.authors = ['Harry Marr']
  gem.email = ['harry@gocardless.com']
  gem.summary = 'A Ruby library for parsing and formatting UK phone numbers.'
  gem.homepage = 'https://github.com/gocardless/uk_phone_numbers'

  gem.add_development_dependency 'rspec', '~> 2.6'

  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec/*`.split("\n")
end
