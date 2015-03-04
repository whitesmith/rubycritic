require "rubycritic/generators/html/base"

module Rubycritic
  module Generator
    module Html

      class SmellsIndex < Base
        TEMPLATE = erb_template("smells_index.html.erb")

        def initialize(analysed_modules)
          @smells = analysed_modules.flat_map(&:smells).uniq
          @analysed_module_names = analysed_module_names(analysed_modules)
          @show_status = (Config.mode == :default)
        end

        def file_name
          "smells_index.html"
        end

        def render
          index_body = TEMPLATE.result(get_binding)
          LAYOUT_TEMPLATE.result(get_binding { index_body })
        end

        private

        def analysed_module_names(analysed_modules)
          names = {}
          analysed_modules.each do |analysed_module|
            names[analysed_module.pathname] = analysed_module.name
          end
          names
        end
      end

    end
  end
end
