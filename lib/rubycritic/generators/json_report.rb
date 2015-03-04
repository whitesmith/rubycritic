require "rubycritic/generators/json/simple"
require "rubycritic/generators/global_rating_calculator"

module Rubycritic
  module Generator

    class JsonReport
      include GlobalRatingCalculator
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
        @gpa = calculate_gpa(analysed_modules)
      end

      def generate_report
        print generator.render
      end

      private

      def generator
        Json::Simple.new(@analysed_modules, @gpa)
      end
    end

  end
end
