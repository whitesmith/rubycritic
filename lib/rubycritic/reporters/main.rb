require "rubycritic/report_generators/overview"
require "rubycritic/report_generators/smells_index"
require "rubycritic/report_generators/code_index"
require "rubycritic/report_generators/code_file"
require "fileutils"

module Rubycritic
  module Reporter

    class Main
      ASSETS_DIR = File.expand_path("../../report_generators/assets", __FILE__)

      def initialize(analysed_files, smells)
        @analysed_files = analysed_files
        @smells = smells
      end

      def generate_report
        generators.each do |generator|
          FileUtils.mkdir_p(generator.file_directory)
          File.open(generator.file_pathname, "w+") do |file|
            file.write(generator.render)
          end
        end
        FileUtils.cp_r(ASSETS_DIR, ::Rubycritic.configuration.root)
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
