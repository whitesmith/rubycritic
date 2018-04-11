# frozen_string_literal: true

require 'rubycritic/generators/html/base'

module RubyCritic
  module Generator
    module Html
      class CodeIndex < Base
        TEMPLATE = erb_template('code_index.html.erb')

        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
          set_header_links if Config.compare_branches_mode?
        end

        def set_header_links
          @base_path = code_index_path(Config.base_root_directory, file_name)
          @feature_path = code_index_path(Config.feature_root_directory, file_name)
          @build_path = code_index_path(Config.build_root_directory, file_name)
        end

        def file_name
          'code_index.html'
        end

        def render
          index_body = TEMPLATE.result(get_binding)
          LAYOUT_TEMPLATE.result(get_binding { index_body })
        end
      end
    end
  end
end
