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

      @source_pathnames.each do |pathname|
        file_smells = @smelly_pathnames[pathname]
        file_generator = FileGenerator.new(pathname, file_smells)

        FileUtils.mkdir_p(file_generator.file_directory)
        File.open(file_generator.file_pathname, "w+") do |report_file|
          report_file.write(file_generator.output)
        end
      end
    end
  end

end
