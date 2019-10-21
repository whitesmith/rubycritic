# frozen_string_literal: true

require 'rubycritic/generators/html/base'

module RubyCritic
  module Generator
    module Html
      class SimpleCovIndex < Base
        TEMPLATE = erb_template('simple_cov_index.html.erb')

        def initialize(analysed_modules)
          @analysed_modules = sorted(filtered(analysed_modules))
          set_header_links if Config.compare_branches_mode?
        end

        def set_header_links
          @base_path = code_index_path(Config.base_root_directory, file_name)
          @feature_path = code_index_path(Config.feature_root_directory, file_name)
          @build_path = code_index_path(Config.compare_root_directory, file_name)
        end

        def file_name
          'simple_cov_index.html'
        end

        def render
          index_body = TEMPLATE.result(base_binding)
          LAYOUT_TEMPLATE.result(base_binding { index_body })
        end

        def sorted(mods)
          mods.sort_by(&:coverage)
        end

        def filtered(mods)
          mods.reject do |a_module|
            path = a_module.pathname.to_s
            path.start_with?('spec', 'test')
          end
        end
      end
    end
  end
end
