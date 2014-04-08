require "erb"
require "rubycritic/report_generators/base_generator"
require "cgi"

module Rubycritic

  class LineGenerator < BaseGenerator
    NORMAL_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "line.html.erb")))
    SMELLY_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "smelly_line.html.erb")))

    def initialize(text, smells)
      @text = CGI::escapeHTML(text.chomp)
      @smells = smells
      @template =
        if @smells.empty?
          NORMAL_TEMPLATE
        else
          SMELLY_TEMPLATE
        end
    end

    def render
      @template.result(binding).delete("\n") + "\n"
    end
  end

end
