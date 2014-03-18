require "erb"

module Rubycritic

  class LineGenerator
    TEMPLATES_DIR = File.expand_path("../templates", __FILE__)
    NORMAL_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "line.html.erb")))
    SMELLY_TEMPLATE = ERB.new(File.read(File.join(TEMPLATES_DIR, "smelly_line.html.erb")))

    def initialize(text, number, smells)
      @text = text.chomp
      @number = number
      @smells = smells
      @template =
        if @smells.empty?
          NORMAL_TEMPLATE
        else
          SMELLY_TEMPLATE
        end
    end

    def output
      @output ||= @template.result(binding).delete("\n") + "\n"
    end
  end

end
