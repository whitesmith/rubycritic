require "erb"
require "rubycritic/report_generators/base_generator"
require "json"

module Rubycritic

  class OverviewGenerator < BaseGenerator
    TEMPLATE = erb_template("overview.html.erb")

    def initialize(turbulence_data)
      @turbulence_data = turbulence_data.to_json
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
