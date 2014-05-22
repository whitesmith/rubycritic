require "rubycritic/report_generators/base"

module Rubycritic
  module Generator

    class CodeIndex < Base
      TEMPLATE = erb_template("code_index.html.erb")

      def initialize(analysed_files)
        @analysed_files = analysed_files
      end

      def file_name
        "code_index.html"
      end

      def render
        index_body = TEMPLATE.result(get_binding)
        LAYOUT_TEMPLATE.result(get_binding { index_body })
      end
    end

  end
end
