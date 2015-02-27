require "cgi"
require "rubycritic/generators/html/base"

module Rubycritic
  module Generator
    module Html

      class Line < Base
        NORMAL_TEMPLATE = erb_template("line.html.erb")
        SMELLY_TEMPLATE = erb_template("smelly_line.html.erb")

        attr_reader :file_directory

        def initialize(file_directory, text, smells)
          @file_directory = file_directory
          @text = CGI.escapeHTML(text.chomp)
          @smells = smells
          @template =
            if @smells.empty?
              NORMAL_TEMPLATE
            else
              SMELLY_TEMPLATE
            end
        end

        def render
          @template.result(binding).delete("\n") + "\n"
        end
      end

    end
  end
end
