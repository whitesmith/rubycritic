require "rubycritic/generators/html/base"
require "rubycritic/generators/html/line"

module Rubycritic
  module Generator
    module Html

      class CodeFile < Base
        LINE_NUMBER_OFFSET = 1
        TEMPLATE = erb_template("code_file.html.erb")

        def initialize(analysed_module)
          @analysed_module = analysed_module
          @pathname = @analysed_module.pathname
        end

        def file_directory
          @file_directory ||= root_directory + @pathname.dirname
        end

        def file_name
          @pathname.basename.sub_ext(".html")
        end

        def render
          file_code = ""
          File.readlines(@pathname).each.with_index(LINE_NUMBER_OFFSET) do |line_text, line_number|
            location = Location.new(@pathname, line_number)
            line_smells = @analysed_module.smells_at_location(location)
            file_code << Line.new(file_directory, line_text, line_smells).render
          end

          file_body = TEMPLATE.result(get_binding { file_code })
          LAYOUT_TEMPLATE.result(get_binding { file_body })
        end
      end

    end
  end
end
