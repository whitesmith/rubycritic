# frozen_string_literal: true

require 'rubycritic/analysers/helpers/flog'
require 'rubycritic/core/smell'
require 'rubycritic/colorize'

module RubyCritic
  module Analyser
    class FlogSmells
      include Colorize
      HIGH_COMPLEXITY_SCORE_THRESHOLD = 25
      VERY_HIGH_COMPLEXITY_SCORE_THRESHOLD = 60

      def initialize(analysed_modules)
        @flog = Flog.new
        @analysed_modules = analysed_modules
      end

      def run
        @analysed_modules.each do |analysed_module|
          add_smells_to(analysed_module)
          print green '.'
        end
        puts ''
      end

      def to_s
        'flog smells'
      end

      private

      def add_smells_to(analysed_module)
        @flog.reset
        @flog.flog(analysed_module.path)
        @flog.each_by_score do |class_method, original_score|
          score = original_score.round
          analysed_module.smells << create_smell(class_method, score) if score >= HIGH_COMPLEXITY_SCORE_THRESHOLD
        end
      end

      def create_smell(context, score)
        Smell.new(
          locations: smell_locations(context),
          context: context,
          message: "has a flog score of #{score}",
          score: score,
          type: type(score),
          analyser: 'flog',
          cost: 0
        )
      end

      def smell_locations(context)
        line = @flog.method_locations[context]
        file_path, file_line = line.split(':')
        [Location.new(file_path, file_line)]
      end

      def type(score)
        if score >= VERY_HIGH_COMPLEXITY_SCORE_THRESHOLD
          'VeryHighComplexity'
        else
          'HighComplexity'
        end
      end
    end
  end
end
