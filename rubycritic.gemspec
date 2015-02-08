# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubycritic/version"

Gem::Specification.new do |spec|
  spec.name          = "rubycritic"
  spec.version       = Rubycritic::VERSION
  spec.authors       = ["Guilherme Simoes"]
  spec.email         = ["guilherme.rdems@gmail.com"]
  spec.description   = "RubyCritic is a tool that wraps around various static analysis gems "\
    "to provide a quality report of your Ruby code."
  spec.summary       = "RubyCritic is a Ruby code quality reporter"
  spec.homepage      = "https://github.com/whitesmith/rubycritic"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 1.9.3"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.require_path  = "lib"

  spec.add_runtime_dependency "virtus", "~> 1.0"
  spec.add_runtime_dependency "flay", "2.4.0"
  spec.add_runtime_dependency "flog", "4.2.1"
  spec.add_runtime_dependency "reek", "1.6.5"
  spec.add_runtime_dependency "parser", ">= 2.2.0", "< 3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.add_development_dependency "mocha", "~> 1.0"
  spec.add_development_dependency "rubocop", "0.28.0"
end
