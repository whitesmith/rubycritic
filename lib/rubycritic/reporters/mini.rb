require "rubycritic/reporters/base"
require "rubycritic/report_generators/code_file"

module Rubycritic
  module Reporter

    class Mini < Base
      def initialize(analysed_file)
        @analysed_file = analysed_file
      end

      def generate_report
        file_generator = Generator::CodeFile.new(@analysed_file)
        create_directories_and_files(file_generator)
        copy_assets_to_report_directory
        file_generator.file_href
      end
    end

  end
end
