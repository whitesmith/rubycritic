# frozen_string_literal: true

require 'rubycritic/generators/json/simple'

module RubyCritic
  module Generator
    class JsonReport
      def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        FileUtils.mkdir_p(generator.file_directory)
        File.open(generator.file_pathname, 'w+') do |file|
          file.write(generator.render)
        end
      end

      private

      def generator
        Json::Simple.new(@analysed_modules)
      end
    end
  end
end
