# frozen_string_literal: true
require 'rubycritic/analysers/helpers/flog'

module RubyCritic
  module Analyser
    class Complexity
      def initialize(analysed_modules, logger=nil)
        @flog = Flog.new
        @analysed_modules = analysed_modules
        @logger = logger
      end

      def run
        @analysed_modules.each do |analysed_module|
          @flog.reset
          @flog.flog(analysed_module.path)
          analysed_module.complexity = @flog.total_score.round

          @logger.report_completion unless @logger.nil?
        end
      end

      def to_s
        'complexity'
      end
    end
  end
end
