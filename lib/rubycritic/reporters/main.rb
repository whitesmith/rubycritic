require "rubycritic/reporters/base"
require "rubycritic/report_generators/overview"
require "rubycritic/report_generators/smells_index"
require "rubycritic/report_generators/code_index"
require "rubycritic/report_generators/code_file"

module Rubycritic
  module Reporter

    class Main < Base
      def initialize(analysed_files, smells)
        @analysed_files = analysed_files
        @smells = smells
      end

      def generate_report
        create_directories_and_files(generators)
        copy_assets_to_report_directory
        overview_generator.file_href
      end

      private

      def generators
        [overview_generator, code_index_generator, smells_index_generator] + file_generators
      end

      def overview_generator
        @overview_generator ||= Generator::Overview.new(@analysed_files)
      end

      def code_index_generator
        Generator::CodeIndex.new(@analysed_files)
      end

      def smells_index_generator
        Generator::SmellsIndex.new(@smells)
      end

      def file_generators
        @analysed_files.map do |analysed_file|
          Generator::CodeFile.new(analysed_file)
        end
      end
    end

  end
end
