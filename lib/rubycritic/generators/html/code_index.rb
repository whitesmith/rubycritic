require "rubycritic/generators/html/base"

module Rubycritic
  module Generator
    module Html

      class CodeIndex < Base
        TEMPLATE = erb_template("code_index.html.erb")

        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
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
end
