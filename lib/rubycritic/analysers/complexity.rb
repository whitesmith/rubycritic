# frozen_string_literal: true

require 'rubycritic/analysers/helpers/flog'
require 'rubycritic/colorize'

module RubyCritic
  module Analyser
    class Complexity
      include Colorize
      def initialize(analysed_modules)
        @flog = Flog.new
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          @flog.reset
          @flog.flog(analysed_module.path)
          analysed_module.complexity = @flog.total_score.round(2)
          print green '.'
        end
        puts ''
      end

      def to_s
        'complexity'
      end
    end
  end
end
