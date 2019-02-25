# frozen_string_literal: true

module RubyCritic
  module Command
    module Utils
      class BuildNumberFile
        attr_reader :file, :build_number

        def initialize
          open_build_number_file
        end

        # keep track of the number of builds and
        # use this build number to create separate directory for each build
        def update_build_number
          @build_number = file.read.to_i + 1
          write_build_number
          build_number
        end

        def write_build_number
          file.rewind
          file.write(build_number)
          file.close
        end

        def open_build_number_file
          root = Config.root
          FileUtils.mkdir_p(root) unless File.directory?(root)
          location = "#{root}/build_number.txt"
          File.new(location, 'a') unless File.exist?(location)
          @file = File.open(location, 'r+')
        end
      end
    end
  end
end
