require "rubycritic/generators/html/code_file"

module Rubycritic
  module Generator
    module Html

      class CurrentCodeFile < CodeFile
        def file_directory
          @file_directory ||= root_directory
        end

        def file_name
          "current_file.html"
        end
      end

    end
  end
end
