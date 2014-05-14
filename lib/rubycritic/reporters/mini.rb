require "rubycritic/report_generators/file_generator"
require "fileutils"

module Rubycritic
  module Reporter

    class Mini
      ASSETS_DIR = File.expand_path("../../report_generators/assets", __FILE__)

      def initialize(analysed_file)
        @analysed_file = analysed_file
      end

      def generate_report
        file_generator = FileGenerator.new(@analysed_file)
        FileUtils.mkdir_p(file_generator.file_directory)
        File.open(file_generator.file_pathname, "w+") do |file|
          file.write(file_generator.render)
        end
        FileUtils.cp_r(ASSETS_DIR, ::Rubycritic.configuration.root)
        file_generator.file_href
      end
    end

  end
end
