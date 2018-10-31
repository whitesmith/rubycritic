# frozen_string_literal: true

require 'rubycritic/generators/html/base'
require 'rubycritic/generators/html/turbulence'
require 'rubycritic/analysis_summary'

module RubyCritic
  module Generator
    module Html
      class Overview < Base
        TEMPLATE = erb_template('overview.html.erb')

        def initialize(analysed_modules)
          @turbulence_data = Turbulence.data(analysed_modules)
          @score = analysed_modules.score
          @max_score = AnalysedModulesCollection::MAX_SCORE
          @summary = analysed_modules.summary
          set_header_links if Config.compare_branches_mode?
        end

        def set_header_links
          @base_path = code_index_path(Config.base_root_directory, file_name)
          @feature_path = code_index_path(Config.feature_root_directory, file_name)
          @build_path = code_index_path(Config.compare_root_directory, file_name)
        end

        def file_name
          'overview.html'
        end

        def render
          index_body = TEMPLATE.result(base_binding)
          LAYOUT_TEMPLATE.result(base_binding { index_body })
        end
      end
    end
  end
end
