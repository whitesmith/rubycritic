# frozen_string_literal: true

require 'rubycritic/generators/text/lint'

module RubyCritic
  module Generator
    class LintReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        FileUtils.mkdir_p(generator.file_directory)
        File.write(generator.file_pathname, reports.join("\n"))
      end

      def generator
        Text::Lint
      end

      def reports
        @analysed_modules.sort.map do |mod|
          generator.new(mod).render
        end
      end
    end
  end
end
