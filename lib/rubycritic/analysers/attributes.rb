# frozen_string_literal: true
require 'rubycritic/analysers/helpers/methods_counter'
require 'rubycritic/analysers/helpers/modules_locator'

module RubyCritic
  module Analyser
    class Attributes
      def initialize(analysed_modules, logger=nil)
        @analysed_modules = analysed_modules
        @logger = logger
      end

      def run
        @analysed_modules.each do |analysed_module|
          analysed_module.methods_count = MethodsCounter.new(analysed_module).count
          analysed_module.name = ModulesLocator.new(analysed_module).first_name

          @logger.report_completion unless @logger.nil?
        end
      end

      def to_s
        'attributes'
      end
    end
  end
end
