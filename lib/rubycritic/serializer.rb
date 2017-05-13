# frozen_string_literal: true

require 'fileutils'

module RubyCritic
  class Serializer
    def initialize(file)
      @file = file
    end

    def load
      Marshal.load(File.binread(@file))
    end

    def dump(content)
      create_file_directory
      File.open(@file, 'w+') do |file|
        Marshal.dump(content, file)
      end
    end

    private

    def create_file_directory
      FileUtils.mkdir_p(file_directory)
    end

    def file_directory
      File.dirname(@file)
    end
  end
end
