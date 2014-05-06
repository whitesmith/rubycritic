require "rubycritic/smell"

module Rubycritic
  module SmellAdapter

    class Flog
      HIGH_COMPLEXITY_SCORE_THRESHOLD = 25
      VERY_HIGH_COMPLEXITY_SCORE_THRESHOLD = 60

      def initialize(flog)
        @flog = flog
      end

      def smells
        smells = []
        @flog.each_by_score do |class_method, original_score|
          score = original_score.round
          smells << create_smell(class_method, score) if score >= HIGH_COMPLEXITY_SCORE_THRESHOLD
        end
        smells
      end

      private

      def create_smell(context, score)
        location = smell_location(context)
        message  = "has a flog score of #{score}"
        type     = type(score)

        Smell.new(
          :locations => [location],
          :context => context,
          :message => message,
          :score => score,
          :type => type
        )
      end

      def smell_location(context)
        line = @flog.method_locations[context]
        file_path, file_line = line.split(":")
        Location.new(file_path, file_line)
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
