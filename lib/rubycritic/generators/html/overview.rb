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
        end

        def file_name
          'overview.html'
        end

        def render
          index_body = TEMPLATE.result(get_binding)
          LAYOUT_TEMPLATE.result(get_binding { index_body })
        end
      end
    end
  end
end
