# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'arel_ext/version'

Gem::Specification.new do |s|
  s.name        = 'arel_ext'
  s.version     = ArelExt::VERSION
  s.date        = '2023-06-23'
  s.summary     = 'Extensions for Arel'
  s.description = 'Extends Arel with some useful features.'
  s.authors     = ['Mònade']
  s.email       = 'team@monade.io'
  s.files = Dir['lib/**/*']
  s.test_files = Dir['spec/**/*']
  s.required_ruby_version = '>= 3.0.0'
  s.homepage    = 'https://rubygems.org/gems/arel_ext'
  s.license     = 'MIT'
  s.add_dependency 'activerecord', ['>= 5', '< 8']
  s.add_dependency 'activesupport', ['>= 5', '< 8']
  s.add_dependency 'arel_extensions', '~> 2.1', '>= 2.1.7'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop'
end
