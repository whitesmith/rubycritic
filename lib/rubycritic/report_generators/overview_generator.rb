require "erb"
require "rubycritic/report_generators/base_generator"

module Rubycritic

  class OverviewGenerator < BaseGenerator
    TEMPLATE = erb_template("overview.html.erb")

    def file_name
      "overview.html"
    end

    def render
      index_body = TEMPLATE.result(get_binding)
      LAYOUT_TEMPLATE.result(get_binding { index_body })
    end
  end

end
