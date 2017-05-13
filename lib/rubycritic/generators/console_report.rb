# frozen_string_literal: true

require 'rubycritic/generators/text/list'

module RubyCritic
  module Generator
    class ConsoleReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        reports = @analysed_modules.sort.map do |mod|
          Text::List.new(mod).render
        end
        puts reports.join("\n")
      end
    end
  end
end
