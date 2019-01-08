# frozen_string_literal: true

module RubyCritic
  module Command
    class StatusReporter
      attr_reader :status, :status_message, :score
      SUCCESS = 0
      SCORE_BELOW_MINIMUM = 1

      def initialize(options)
        @options = options
        @status = SUCCESS
      end

      def score=(input_score)
        @score = input_score.round(2)
        update_status
      end

      private

      def update_status
        @status = current_status
        update_status_message
      end

      def current_status
        satisfy_minimum_score_rule ? SUCCESS : SCORE_BELOW_MINIMUM
      end

      def satisfy_minimum_score_rule
        score >= @options[:minimum_score].to_f
      end

      def update_status_message
        case @status
        when SUCCESS
          @status_message = "Score: #{score}"
        when SCORE_BELOW_MINIMUM
          @status_message = "Score (#{score}) is below the minimum #{@options[:minimum_score]}"
        end
      end
    end
  end
end
