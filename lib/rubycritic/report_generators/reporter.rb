require "rubycritic/report_generators/file_generator"
require "rubycritic/report_generators/overview_generator"
require "rubycritic/report_generators/code_index_generator"
require "rubycritic/report_generators/smells_index_generator"
require "fileutils"

module Rubycritic

  class Reporter
    ASSETS_DIR = File.expand_path("../assets", __FILE__)

    def initialize(analysed_files, smells)
      @analysed_files = analysed_files
      @smells = smells
    end

    def generate_report
      generators.each do |generator|
        FileUtils.mkdir_p(generator.file_directory)
        File.open(generator.file_pathname, "w+") do |file|
          file.write(generator.render)
        end
      end
      FileUtils.cp_r(ASSETS_DIR, ::Rubycritic.configuration.root)
      overview_generator.file_href
    end

    private

    def generators
      [overview_generator, code_index_generator, smells_index_generator] + file_generators
    end

    def overview_generator
      @overview_generator ||= OverviewGenerator.new(@analysed_files)
    end

    def code_index_generator
      CodeIndexGenerator.new(@analysed_files)
    end

    def smells_index_generator
      SmellsIndexGenerator.new(@smells)
    end

    def file_generators
      @analysed_files.map do |analysed_file|
        FileGenerator.new(analysed_file)
      end
    end
  end

end
