require "cgi"
require "rubycritic/generators/html/base"
require "rubycritic/generators/html/line_reports"

module Rubycritic
  module Generator
    module Html

      class Line < Base
        TEMPLATE = erb_template("line.html.erb")

        attr_reader :file_directory

        def initialize(file_directory, text, smells, styles)
          @file_directory = file_directory
          @text = CGI.escapeHTML(text.chomp)
          @smells = smells
          @styles = styles
        end

        def render
          reports = ""
          reports << LineReports.new(@file_directory, @smells, "smell").render
          reports << LineReports.new(@file_directory, @styles, "style").render
          TEMPLATE.result(get_binding { reports }).delete("\n") + "\n"
        end
      end

    end
  end
end
