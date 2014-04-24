require "fileutils"

module Rubycritic

  class SmellyPathnamesSerializer
    def initialize(file_name)
      @file_name = file_name
    end

    def load
      Marshal.load(File.binread(@file_name))
    end

    def dump(smelly_pathnames)
      create_file_directory
      # HACK It's not possible to Marshal procs or lambdas.
      smelly_pathnames.default = []
      File.open(@file_name, "w+") do |file|
        Marshal.dump(smelly_pathnames, file)
      end
    end

    private

    def create_file_directory
      FileUtils.mkdir_p(file_directory)
    end

    def file_directory
      File.dirname(@file_name)
    end
  end

end
