# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
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
  spec.required_ruby_version = '>= 2.6.0'

  spec.files = [
    'CHANGELOG.md',
    'CONTRIBUTING.md',
    'Gemfile',
    'LICENSE.txt',
    'README.md',
    'ROADMAP.md',
    'Rakefile'
  ]
  spec.files += `git ls-files lib`.split("\n")

  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_path  = 'lib'

  spec.add_runtime_dependency 'flay', '~> 2.8'
  spec.add_runtime_dependency 'flog', '~> 4.4'
  spec.add_runtime_dependency 'launchy', '>= 2.0.0'
  spec.add_runtime_dependency 'parser', '>= 2.6.0'
  spec.add_runtime_dependency 'rainbow', '~> 3.0'
  spec.add_runtime_dependency 'reek', '~> 6.0', '< 7.0'
  spec.add_runtime_dependency 'ruby_parser', '~> 3.8'
  spec.add_runtime_dependency 'simplecov', '>= 0.17.0'
  spec.add_runtime_dependency 'tty-which', '~> 0.4.0'
  spec.add_runtime_dependency 'virtus', '~> 1.0'

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'aruba', '~> 0.12', '>= 0.12.0'
  spec.add_development_dependency 'bundler', '~> 2.0', '>= 2.0.0'
  if RUBY_PLATFORM == 'java'
    spec.add_development_dependency 'pry-debugger-jruby'
  else
    spec.add_development_dependency 'byebug', '~> 11.0', '>= 10.0'
  end
  spec.add_development_dependency 'cucumber', '~> 3.0', '>= 2.2.0'
  spec.add_development_dependency 'diff-lcs', '~> 1.3'
  spec.add_development_dependency 'fakefs', '~> 1.3.2', '< 2.0.0'
  spec.add_development_dependency 'mdl', '~> 0.5.0'
  spec.add_development_dependency 'minitest', '>= 5.3.0'
  spec.add_development_dependency 'minitest-around', '~> 0.5.0', '>= 0.4.0'
  spec.add_development_dependency 'mocha', '~> 1.1', '>= 1.1.0'
  spec.add_development_dependency 'rake', '~> 12.0', '>= 11.0.0'
  spec.add_development_dependency 'rexml', '>= 3.2.0'
  spec.add_development_dependency 'rubocop', '~> 0.65.0'
end
