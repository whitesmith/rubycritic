require "rubycritic/report_generators/code_file"

module Rubycritic
  module Generator

    class CurrentCodeFile < CodeFile
      def file_directory
        root_directory
      end

      def file_name
        "current_file.html"
      end
    end

  end
end
