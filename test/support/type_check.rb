# frozen_string_literal: true

require 'pathname'
require 'rubycritic/core/smell'
require 'rubycritic/core/analysed_module'

# Test-only "micro-Sorbet". Wraps attribute writers so that assigning a value
# of an unexpected type raises immediately, catching type regressions in the
# plain-Ruby accessors that replaced virtus. It is loaded only through
# test_helper, is never required by production code, and is never shipped
# (the gemspec packages `lib` only), so it has zero runtime impact.
module TypeCheckHelper
  # Raised when a wrapped writer receives a value of an unexpected type.
  class TypeError < ::TypeError; end

  # Does `value` satisfy any of the `allowed` type entries? An entry may be a
  # Module (matched with is_a?) or a String naming a class that might not be
  # loaded when the spec is defined (e.g. the FakeFS::Pathname test double),
  # matched by name against the value's ancestors.
  def self.match?(value, allowed)
    allowed.any? do |type|
      if type.is_a?(Module)
        value.is_a?(type)
      else
        value.class.ancestors.any? { |ancestor| ancestor.name == type }
      end
    end
  end

  # Builds an anonymous module that, when included, prepends type-checking
  # wrappers around the named writers of the including class. `prepend` is
  # required (not plain include) so the wrapper's `name=` wins over the
  # `attr_accessor` writer defined directly on the class, while `super`
  # still reaches that original writer.
  def self.build(specs)
    Module.new do
      define_singleton_method(:included) do |base|
        wrapper = Module.new do
          specs.each do |name, expected|
            allowed = Array(expected)
            define_method("#{name}=") do |value|
              unless value.nil? || TypeCheckHelper.match?(value, allowed)
                raise TypeCheckHelper::TypeError,
                      "#{base}##{name}= expected #{allowed.join(' | ')} or nil, " \
                      "got #{value.class} (#{value.inspect})"
              end

              super(value)
            end
          end
        end

        base.prepend(wrapper)
      end
    end
  end
end

# Test-only DSL so a class can declare `include TypeCheck(attr: Type, ...)`.
# Defined privately on Kernel so the bare `TypeCheck(...)` call resolves inside
# a class body (where `self` is the class). A nil value is always permitted; a
# spec value may be a single class or an array of classes (a union).
module Kernel
  private

  def TypeCheck(specs)
    TypeCheckHelper.build(specs)
  end
end

module RubyCritic
  class Smell
    include TypeCheck(
      cost: Numeric,
      score: Numeric,
      locations: Array,
      status: Symbol,
      context: String,
      message: String,
      type: [String, Symbol],
      analyser: String
    )
  end

  class AnalysedModule
    include TypeCheck(
      coverage: Numeric,
      complexity: Numeric,
      duplication: Numeric,
      churn: Integer,
      methods_count: Integer,
      name: String,
      pathname: [Pathname, 'FakeFS::Pathname'],
      smells: Array
    )
  end
end
