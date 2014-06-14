require "rubycritic/report_generators/base"
require "rubycritic/turbulence"

module Rubycritic
  module Generator

    class Overview < Base
      TEMPLATE = erb_template("overview.html.erb")

      def initialize(analysed_files)
        @turbulence_data = Turbulence.data(analysed_files)
      end

      def file_name
        "overview.html"
      end

      def render
        index_body = TEMPLATE.result(get_binding)
        LAYOUT_TEMPLATE.result(get_binding { index_body })
      end
    end

  end
end
