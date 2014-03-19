require "cgi"
require "erb"

module Rubycritic

  class LineGenerator < BaseGenerator
    LINE_NUMBER_PADDING = 3
    NORMAL_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "line.html.erb")))
    SMELLY_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "smelly_line.html.erb")))

    def initialize(text, number, smells)
      @text = CGI::escapeHTML(text.chomp)
      @number = number.to_s.rjust(LINE_NUMBER_PADDING)
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
