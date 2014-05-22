require "rubycritic/report_generators/base"

module Rubycritic
  module Generator

    class SmellsIndex < Base
      TEMPLATE = erb_template("smells_index.html.erb")

      def initialize(smells)
        @smells = smells
      end

      def file_name
        "smells_index.html"
      end

      def render
        index_body = TEMPLATE.result(get_binding)
        LAYOUT_TEMPLATE.result(get_binding { index_body })
      end
    end

  end
end
