require "rubycritic/report_generators/base_generator"
require "rubycritic/report_generators/file_generator"
require "rubycritic/report_generators/index_generator"
require "fileutils"

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
      index_generator.file_href
    end

    private

    def generators
      file_generators + [index_generator]
    end

    def index_generator
      @index_generator ||= IndexGenerator.new(file_generators)
    end

    def file_generators
      @file_generators ||= @source_pathnames.map do |file_pathname|
        file_smells = @smelly_pathnames[file_pathname]
        FileGenerator.new(file_pathname, file_smells)
      end
    end
  end

end
