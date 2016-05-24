require 'fileutils'
require 'rubycritic/config'
require 'rubycritic/generators/html_report'
require 'rubycritic/generators/rails/overview'
require 'rubycritic/generators/rails/smells_index'
require 'rubycritic/generators/rails/code_index'
require 'rubycritic/generators/rails/code_file'

module Rubycritic
  module Generator
    class RailsReport < HtmlReport
      JAVASCRIPTS_DIR = File.expand_path('../html/assets/javascripts', __FILE__)
      STYLESHEETS_DIR = File.expand_path('../html/assets/stylesheets', __FILE__)

      private

      def overview_generator
        @overview_generator ||= Rails::Overview.new(@analysed_modules)
      end

      def code_index_generator
        Rails::CodeIndex.new(@analysed_modules)
      end

      def smells_index_generator
        Rails::SmellsIndex.new(@analysed_modules)
      end

      def file_generators
        @analysed_modules.map do |analysed_module|
          Rails::CodeFile.new(analysed_module)
        end
      end

      def copy_assets_to_report_directory
        FileUtils.cp_r(STYLESHEETS_DIR, Pathname.new(Config.root) + 'vendor/assets/stylesheets/rubycritic')
        FileUtils.cp_r(JAVASCRIPTS_DIR, Pathname.new(Config.root) + 'vendor/assets/javascripts/rubycritic')
      end

    end
  end
end
