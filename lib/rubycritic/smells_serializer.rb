require "fileutils"

module Rubycritic

  class SmellsSerializer
    def initialize(file_name)
      @file_name = file_name
    end

    def load
      Marshal.load(File.binread(@file_name))
    end

    def dump(smells)
      create_file_directory
      File.open(@file_name, "w+") do |file|
        Marshal.dump(smells, file)
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
