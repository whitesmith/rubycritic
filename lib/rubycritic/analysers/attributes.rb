# frozen_string_literal: true

require 'rubycritic/analysers/helpers/methods_counter'
require 'rubycritic/analysers/helpers/modules_locator'
require 'rubycritic/colorize'

module RubyCritic
  module Analyser
    class Attributes
      include Colorize
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.methods_count = MethodsCounter.new(analysed_module).count
          analysed_module.name = ModulesLocator.new(analysed_module).first_name
          print green '.'
        end
        puts ''
      end

      def to_s
        'attributes'
      end
    end
  end
end
