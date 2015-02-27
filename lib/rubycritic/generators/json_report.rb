require "fileutils"
require "rubycritic/generators/json/simple"

module Rubycritic
  module Generator

    class JsonReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        create_directories_and_files
        puts "New JSON critique at #{report_location}"
      end

      private

      def create_directories_and_files
        FileUtils.mkdir_p(generator.file_directory)
        File.open(generator.file_pathname, "w+") do |file|
          file.write(generator.render)
        end
      end

      def generator
        @generator ||= Json::Simple.new(@analysed_modules)
      end

      def report_location
        generator.file_href
      end
    end

  end
end
