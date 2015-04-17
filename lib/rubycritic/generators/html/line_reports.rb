require "cgi"
require "rubycritic/generators/html/base"

module Rubycritic
  module Generator
    module Html

      class LineReports < Base
        TEMPLATE = erb_template("line_reports.html.erb")

        attr_reader :file_directory

        def initialize(file_directory, reports, report_type)
          @file_directory = file_directory
          @reports = reports
          @report_type = report_type
        end

        def render
          if @reports.any?
            TEMPLATE.result(binding)
          else
            ""
          end
        end
      end

    end
  end
end
