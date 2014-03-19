require "fileutils"
require "rubycritic/report_generators/base_generator"
require "rubycritic/report_generators/file_generator"

module Rubycritic

  class Reporter
    ASSETS_DIR = File.expand_path("../assets", __FILE__)

    def initialize(source_pathnames, smelly_pathnames)
      @source_pathnames = source_pathnames
      @smelly_pathnames = smelly_pathnames
    end

    def generate_report
      generators.each do |generator|
        FileUtils.mkdir_p(generator.file_directory)
        File.open(generator.file_pathname, "w+") do |file|
          file.write(generator.render)
        end
      end
      FileUtils.cp_r(ASSETS_DIR, BaseGenerator::REPORT_DIR)
    end

    private

    def generators
      @source_pathnames.map do |pathname|
        file_smells = @smelly_pathnames[pathname]
        FileGenerator.new(pathname, file_smells)
      end
    end
  end

end
