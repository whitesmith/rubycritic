# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubycritic/version"

Gem::Specification.new do |spec|
  spec.name          = "rubycritic"
  spec.version       = Rubycritic::VERSION
  spec.authors       = ["Guilherme Simoes"]
  spec.email         = ["guilherme.rdems@gmail.com"]
  spec.description   = <<-EOF
    Ruby Critic is a tool that detects and reports smells in Ruby classes, modules and methods.
  EOF
  spec.summary       = "Ruby code smell detector"
  spec.homepage      = "https://github.com/GuilhermeSimoes/rubycritic"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{lib}/**/*") + %w[LICENSE.txt README.md]
  spec.executables   = Dir.glob("{bin}/*").map { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.require_path  = "lib"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
