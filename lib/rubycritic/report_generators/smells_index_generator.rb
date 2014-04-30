require "erb"
require "rubycritic/report_generators/base_generator"

module Rubycritic

  class SmellsIndexGenerator < BaseGenerator
    TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "smells_index.html.erb")))

    def initialize(smells)
      @smells = smells.sort { |a, b| a.type <=> b.type }
    end

    def file_name
      "smells_index.html"
    end

    def render
      index_body = TEMPLATE.result(get_binding)
      LAYOUT_TEMPLATE.result(get_binding { index_body })
    end
  end

end
