# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubycritic/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubycritic'
  spec.version       = RubyCritic::VERSION
  spec.authors       = ['Guilherme Simoes']
  spec.email         = ['guilherme.rdems@gmail.com']
  spec.description   = 'RubyCritic is a tool that wraps around various static analysis gems '\
    'to provide a quality report of your Ruby code.'
  spec.summary       = 'RubyCritic is a Ruby code quality reporter'
  spec.homepage      = 'https://github.com/whitesmith/rubycritic'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.require_path  = 'lib'

  spec.add_runtime_dependency 'virtus', '~> 1.0'
  spec.add_runtime_dependency 'flay', '~> 2.8'
  spec.add_runtime_dependency 'flog', '~> 4.4'
  spec.add_runtime_dependency 'reek', '~> 4.4'
  spec.add_runtime_dependency 'parser', '2.3.1.2'
  spec.add_runtime_dependency 'ruby_parser', '~> 3.8'
  spec.add_runtime_dependency 'colorize'
  spec.add_runtime_dependency 'launchy', '2.4.3'

  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.3'
  spec.add_development_dependency 'mocha', '~> 1.1'
  spec.add_development_dependency 'rubocop', '>= 0.42.0'
  spec.add_development_dependency 'pry-byebug'
end
