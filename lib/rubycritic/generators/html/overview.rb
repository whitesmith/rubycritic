require "rubycritic/generators/html/base"
require "rubycritic/generators/html/turbulence"

module Rubycritic
  module Generator
    module Html

      class Overview < Base
        TEMPLATE = erb_template("overview.html.erb")

        def initialize(analysed_modules)
          @turbulence_data = Turbulence.data(analysed_modules)
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
end
