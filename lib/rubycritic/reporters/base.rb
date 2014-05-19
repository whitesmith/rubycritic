require "fileutils"

module Rubycritic
  module Reporter

    class Base
      ASSETS_DIR = File.expand_path("../../report_generators/assets", __FILE__)

      def create_directories_and_files(generators)
        Array(generators).each do |generator|
          FileUtils.mkdir_p(generator.file_directory)
          File.open(generator.file_pathname, "w+") do |file|
            file.write(generator.render)
          end
        end
      end

      def copy_assets_to_report_directory
        FileUtils.cp_r(ASSETS_DIR, ::Rubycritic.configuration.root)
      end
    end

  end
end
