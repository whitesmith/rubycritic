require "rubycritic/report_generators/base_generator"
require "rubycritic/report_generators/file_generator"
require "rubycritic/report_generators/code_index_generator"
require "rubycritic/report_generators/smells_index_generator"
require "fileutils"

module Rubycritic

  class Reporter
    ASSETS_DIR = File.expand_path("../assets", __FILE__)

    def initialize(source_pathnames, smells)
      @source_pathnames = source_pathnames
      @smells = smells
      @smelly_pathnames = pathnames_to_files_with_smells
    end

    def generate_report
      generators.each do |generator|
        FileUtils.mkdir_p(generator.file_directory)
        File.open(generator.file_pathname, "w+") do |file|
          file.write(generator.render)
        end
      end
      FileUtils.cp_r(ASSETS_DIR, ::Rubycritic.configuration.root)
      code_index_generator.file_href
    end

    private

    def generators
      [code_index_generator, smells_index_generator] + file_generators
    end

    def code_index_generator
      @code_index_generator ||= CodeIndexGenerator.new(@source_pathnames, @smelly_pathnames)
    end

    def smells_index_generator
      @smells_index_generator ||= SmellsIndexGenerator.new(@smells)
    end

    def file_generators
      @file_generators ||= @source_pathnames.map do |file_pathname|
        file_smells = @smelly_pathnames[file_pathname]
        FileGenerator.new(file_pathname, file_smells)
      end
    end

    def pathnames_to_files_with_smells
      pathnames = Hash.new { |hash, key| hash[key] = [] }
      @smells.each do |smell|
        smell.pathnames.each do |path|
          pathnames[path] << smell
        end
      end
      pathnames
    end
  end

end
