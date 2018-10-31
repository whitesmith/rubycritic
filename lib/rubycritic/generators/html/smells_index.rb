# frozen_string_literal: true

require 'rubycritic/generators/html/base'

module RubyCritic
  module Generator
    module Html
      class SmellsIndex < Base
        TEMPLATE = erb_template('smells_index.html.erb')

        def initialize(analysed_modules)
          @smells = analysed_modules.flat_map(&:smells).uniq
          @analysed_module_names = analysed_module_names(analysed_modules)
          @show_status = (Config.mode == :default)
          set_header_links if Config.compare_branches_mode?
        end

        def set_header_links
          @base_path = code_index_path(Config.base_root_directory, file_name)
          @feature_path = code_index_path(Config.feature_root_directory, file_name)
          @build_path = code_index_path(Config.compare_root_directory, file_name)
        end

        def file_name
          'smells_index.html'
        end

        def render
          index_body = TEMPLATE.result(base_binding)
          LAYOUT_TEMPLATE.result(base_binding { index_body })
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
