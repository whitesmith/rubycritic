require "rubycritic/generators/json/simple"

module Rubycritic
  module Generator

    class JsonReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        print generator.render
      end

      private

      def generator
        Json::Simple.new(@analysed_modules)
      end
    end

  end
end
