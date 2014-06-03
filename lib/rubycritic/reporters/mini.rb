require "rubycritic/reporters/base"
require "rubycritic/report_generators/current_code_file"

module Rubycritic
  module Reporter

    class Mini < Base
      def initialize(analysed_files)
        @analysed_file = analysed_files.first
      end

      def generate_report
        create_directories_and_files(file_generator)
        copy_assets_to_report_directory
        report_location
      end

      private

      def file_generator
        @file_generator ||= Generator::CurrentCodeFile.new(@analysed_file)
      end

      def report_location
        file_generator.file_href
      end
    end

  end
end
