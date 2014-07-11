require "rubycritic/analysers/adapters/flog"
require "rubycritic/core/smell"

module Rubycritic
  module Analyser

    class FlogSmells
      HIGH_COMPLEXITY_SCORE_THRESHOLD = 25
      VERY_HIGH_COMPLEXITY_SCORE_THRESHOLD = 60

      def initialize(analysed_files)
        @flog = Flog.new
        @analysed_files = analysed_files
      end

      def run
        @analysed_files.each do |analysed_file|
          add_smells_to(analysed_file)
        end
      end

      private

      def add_smells_to(analysed_file)
        @flog.reset
        @flog.flog(analysed_file.path)
        @flog.each_by_score do |class_method, original_score|
          score = original_score.round
          if score >= HIGH_COMPLEXITY_SCORE_THRESHOLD
            analysed_file.smells << create_smell(class_method, score)
          end
        end
      end

      def create_smell(context, score)
        Smell.new(
          :locations => smell_locations(context),
          :context   => context,
          :message   => "has a flog score of #{score}",
          :score     => score,
          :type      => type(score),
          :cost      => 0
        )
      end

      def smell_locations(context)
        line = @flog.method_locations[context]
        file_path, file_line = line.split(":")
        [Location.new(file_path, file_line)]
      end

      def type(score)
        if score >= VERY_HIGH_COMPLEXITY_SCORE_THRESHOLD
          "VeryHighComplexity"
        else
          "HighComplexity"
        end
      end
    end

  end
end
