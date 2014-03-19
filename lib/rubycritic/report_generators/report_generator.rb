require "fileutils"
require "rubycritic/report_generators/file_generator"

module Rubycritic

  class ReportGenerator
    ASSETS_DIR = File.expand_path("../assets", __FILE__)
    REPORT_DIR = File.expand_path("tmp/rubycritic", Dir.getwd)

    def initialize(source_pathnames, smelly_pathnames)
      @source_pathnames = source_pathnames
      @smelly_pathnames = smelly_pathnames
    end

    def generate_report
      FileUtils.mkdir_p(REPORT_DIR)
      FileUtils.cp_r(ASSETS_DIR, REPORT_DIR)

      generators.each do |generator|
        FileUtils.mkdir_p(generator.file_directory)
        File.open(generator.file_pathname, "w+") do |file|
          file.write(generator.render)
        end
      end
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
